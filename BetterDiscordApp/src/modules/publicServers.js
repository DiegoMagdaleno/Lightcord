import {settingsCookie} from "../0globals";
import BDV2 from "./v2";
import webpackModules from "./webpackModules";
import Utils from "./utils";
import DOM from "./domtools";

import V2C_PublicServers from "../ui/publicservers/publicServers";
import Layers from "./Layers";

export default new class V2_PublicServers {

    constructor() {
        this._appendButton = this._appendButton.bind(this);
        window.Lightcord.BetterDiscord.V2_PublicServers = this
    }

    render() {
        Layers.createLayer((close) => {
            return BDV2.react.createElement(V2C_PublicServers, {rootId: "pubslayerroot", close})
        })
    }

    get button() {
        const btn = DOM.createElement(`<div id="bd-pub-li" class="${BDV2.guildClasses.listItem}">`);
        if (!settingsCookie["bda-gs-1"]) btn.style.display = "none";
        const label = DOM.createElement(`<div id="bd-pub-button" class="${"wrapper-25eVIn " + BDV2.guildClasses.circleButtonMask}">public</div>`);
        label.addEventListener("click", () => {this.render();});
        btn.append(label);
        return btn;
    }

    _appendButton() {
        let [
            classNametutorialContainer
        ] = [
            Utils.removeDa(BDModules.get(e => e.downloadProgress && e.tutorialContainer)[0].tutorialContainer)
        ]
        if (DOM.query("#bd-pub-li")) return;
        const guilds = DOM.query(`div.${classNametutorialContainer} > div`);
        DOM.after(guilds, this.button);
    }

    addButton() {
        if (this.guildPatch) return;
        const GuildList = webpackModules.find(m => m.default && m.default.displayName == "NavigableGuilds");
        const GuildListOld = webpackModules.findByDisplayName("Guilds");
        if (!GuildList && !GuildListOld) Utils.warn("PublicServer", "Can't find GuildList component");
        this.guildPatch = Utils.monkeyPatch(GuildList ? GuildList : GuildListOld.prototype, GuildList ? "default" : "render", {after: this._appendButton});
        this._appendButton();
    }

    removeButton() {
        this.guildPatch();
        delete this.guildPatch;
        const button = DOM.query("#bd-pub-li");
        if (button) button.remove();
    }
};