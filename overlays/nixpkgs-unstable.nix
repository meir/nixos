{ unstable, ... }:
final: prev: { unstable = import unstable (final // { config.allowUnfree = true; }); }
