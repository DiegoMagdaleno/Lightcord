const native = require('./discord_media_'+process.platform+'.node');

module.exports = {
  getSystemAnalyticsBlob() {
    return new Promise(resolve => native.getSystemAnalyticsBlob(resolve));
  },
};
