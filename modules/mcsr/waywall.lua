local waywall = require("waywall")
local helpers = require("waywall.helpers")

local config = {
    theme = {
        background = "#303030ff",
        ninb_anchor = "topright",
    },
}

config.actions = {
    ["Ctrl-Shift-N"] = function()
        waywall.exec(
            "java -Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel -jar /home/n0op3/Apps/Ninjabrain-Bot-1.5.1.jar")
    end,
    ["Ctrl-N"] = function()
        helpers.toggle_floating()
    end
}

return config
