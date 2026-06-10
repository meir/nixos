// @onlyonce
(() => {
  const file = Services.dirsvc.get("UChrm", Ci.nsIFile);
  file.append("userChrome.css");

  let last = file.exists() ? file.lastModifiedTime : 0;

  setInterval(() => {
    if (file.refresh) file.refresh();
    if (file.exists() && file.lastModifiedTime !== last) {
      last = file.lastModifiedTime;
      UC_API.Scripts.reloadStyleSheet();
      console.log("userChrome.css reloaded");
    }
  }, 250);
})();
