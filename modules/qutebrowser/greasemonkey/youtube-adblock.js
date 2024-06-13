// change if you need it
// dont let youtube win this one
// fight back with this script

document.addEventListener('load', () => {
  const btn = document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button-modern')
  if (btn) btn.click()

  const ad = document.querySelectorAll('.ad-showing')[0];
  if (ad) {
    const video = document.querySelector('video');
    const hyperdrive = 299792458; // speed of light in meters per second
    video.defaultPlaybackRate = hyperdrive;
    video.playbackRate = hyperdrive;
  }
}, true);
