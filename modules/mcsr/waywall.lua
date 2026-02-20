local waywall = require("waywall")
local helpers = require("waywall.helpers")
local Processes = require("waywork.processes")

local config = {
    theme = {
        background = "#303030ff",
        ninb_anchor = "topright",
    },
}

local ensure_ninjabrain = Processes.ensure_application(waywall, programs.ninjabrain_bot)("ninjabrain.*\\.jar")
waywall.listen("load", ensure_ninjabrain)

config.input = {
    sensitivity = 8.02283846,
}

config.actions = {
    ["Ctrl-Shift-N"] = function()
        ensure_ninjabrain()
        helpers.show_floating()
    end,
    ["Ctrl-N"] = function()
        helpers.toggle_floating()
    end
}

return config
