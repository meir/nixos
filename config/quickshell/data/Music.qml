pragma Singleton
import Quickshell
import Quickshell.Services.Mpris
import QtQuick

Singleton {
  id: root

  property string title: ""
  property string artist: ""
  property list<string> artists: []
  property string album: ""
  property string artUrl: ""
  property bool isPlaying: false
  property real position: 0

  property var players: Mpris.players.values
  property var activePlayer: Mpris.activePlayer

  function updateActive() {
    const playing = players.find((player) => {
      return player.playbackState == MprisPlaybackState.Playing;
    })

    
    if (players.length > 0) {
      if (playing) {
        activePlayer = playing;
        return
      }

      activePlayer = players[0];
      return
    }

    activePlayer = null;
  }

  function updateData() {
    title = activePlayer.trackTitle || ""
    artist = activePlayer.trackArtist || ""
    artists = activePlayer.trackArtists || []
    album = activePlayer.trackAlbum || ""
    artUrl = activePlayer.trackArtUrl || ""
    isPlaying = activePlayer.isPlaying || false
    position = activePlayer.position || 0
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      updateActive();
      updateData();
    }
  }
}
