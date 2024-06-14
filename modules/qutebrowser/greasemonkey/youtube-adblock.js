// change if you need it
// dont let youtube win this one
// fight back with this script

document.addEventListener('load', () => {
  const btn = document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button-modern')
  if (btn) btn.click()

  const ad = document.querySelectorAll('.ad-showing')[0];
  if (ad) {
    const video = document.querySelector('video');
    // replace video with a videoProxy
    video.playbackRate = 5;
  }
}, true);
