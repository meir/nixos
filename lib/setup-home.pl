# https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/system/etc/setup-etc.pl
use strict;
use File::Find;
use File::Copy;
use File::Path;
use File::Basename;
use File::Slurp;

my $store = $ARGV[0] or die;
my $home = $ARGV[1] or die;
my $static = "$home/static";

sub atomicSymlink {
    my ($source, $target) = @_;
    my $tmp = "$target.tmp";
    unlink $tmp;
    symlink $source, $tmp or return 0;
    if (rename $tmp, $target) {
        return 1;
    } else {
        unlink $tmp;
        return 0;
    }
}


# Atomically update $HOME/static to point at the home files of the
# current configuration.
atomicSymlink $store, $static or die;

# Returns 1 if the argument points to the files in /etc/static.  That
# means either argument is a symlink to a file in /etc/static or a
# directory with all children being static.
sub isStatic {
    my $path = shift;

    if (-l $path) {
        my $target = readlink $path;
        return substr($target, 0, length "$home/static/") eq "$home/static/";
    }

    if (-d $path) {
        opendir DIR, "$path" or return 0;
        my @names = readdir DIR or die;
        closedir DIR;

        foreach my $name (@names) {
            next if $name eq "." || $name eq "..";
            unless (isStatic("$path/$name")) {
                return 0;
            }
        }
        return 1;
    }

    return 0;
}

# Remove dangling symlinks that point to /etc/static.  These are
# configuration files that existed in a previous configuration but not
# in the current one.  For efficiency, don't look under /etc/nixos
# (where all the NixOS sources live).
sub cleanup {
    if ($File::Find::name eq "$home/.nixos-profile") {
        $File::Find::prune = 1;
        return;
    }
    if (-l $_) {
        my $target = readlink $_;
        if (substr($target, 0, length $static) eq $static) {
            my $x = "$home/static/" . substr($File::Find::name, length "$home/");
            unless (-l $x) {
                print STDERR "removing obsolete symlink ‘$File::Find::name’...\n";
                unlink "$_";
            }
        }
    }
}

find(\&cleanup, "$home");


# Use /etc/.clean to keep track of copied files.
my @oldCopied = read_file("$home/.clean", chomp => 1, err_mode => 'quiet');
open CLEAN, ">>$home/.clean";


# For every file in the etc tree, create a corresponding symlink in
# /etc to /etc/static.  The indirection through /etc/static is to make
# switching to a new configuration somewhat more atomic.
my %created;
my @copied;

sub link {
    my $fn = substr $File::Find::name, length($store) + 1 or next;

    my $target = "$home/$fn";
    File::Path::make_path(dirname $target);
    $created{$fn} = 1;

    # Rename doesn't work if target is directory.
    if (-l $_ && -d $target) {
        if (isStatic $target) {
            rmtree $target or warn;
        } else {
            warn "$target directory contains user files. Symlinking may fail.";
        }
    }

    if (-e "$_.mode") {
        my $mode = read_file("$_.mode"); chomp $mode;
        if ($mode eq "direct-symlink") {
            atomicSymlink readlink("$static/$fn"), $target or warn "could not create symlink $target";
        } else {
            my $uid = read_file("$_.uid"); chomp $uid;
            my $gid = read_file("$_.gid"); chomp $gid;
            copy "$static/$fn", "$target.tmp" or warn;
            $uid = getpwnam $uid unless $uid =~ /^\+/;
            $gid = getgrnam $gid unless $gid =~ /^\+/;
            chown int($uid), int($gid), "$target.tmp" or warn;
            chmod oct($mode), "$target.tmp" or warn;
            unless (rename "$target.tmp", $target) {
                warn "could not create target $target";
                unlink "$target.tmp";
            }
        }
        push @copied, $fn;
        print CLEAN "$fn\n";
    } elsif (-l "$_") {
        atomicSymlink "$static/$fn", $target or warn "could not create symlink $target";
    }
}

find(\&link, $store);


# Delete files that were copied in a previous version but not in the
# current.
foreach my $fn (@oldCopied) {
    if (!defined $created{$fn}) {
        $fn = "/etc/$fn";
        print STDERR "removing obsolete file ‘$fn’...\n";
        unlink "$fn";
    }
}


# Rewrite /etc/.clean.
close CLEAN;
write_file("$home/.clean", map { "$_\n" } sort @copied);

# Create /etc/NIXOS tag if not exists.
# When /etc is not on a persistent filesystem, it will be wiped after reboot,
# so we need to check and re-create it during activation.
open TAG, ">>$home/NIXOS";
close TAG;
