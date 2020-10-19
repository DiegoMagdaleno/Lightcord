'use strict';

const electron = require('electron');
const { getDiscordIPCEvent } = require('../common/constants');

const ipcRenderer = electron.ipcRenderer;

function send(ev, ...args) {
  const event = getDiscordIPCEvent(ev)
  ipcRenderer.send(event, ...args);
}

function on(ev, callback) {
  const event = getDiscordIPCEvent(ev)
  ipcRenderer.on(event, callback);
}

module.exports = {
  send,
  on
};