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

-- PATHS --
local home_path = os.getenv("HOME") .. "/"
local overlay_path = home_path .. ".config/waywall/measuring_overlay.png"

-- MIRRORS --
local make_mirror = function(options)
    local this = nil

    return function(enable)
        if enable and not this then
            this = waywall.mirror(options)
        elseif this and not enable then
            this:close()
            this = nil
        end
    end
end

local mirrors = {
    thin_e = make_mirror({
        src = { x = 0, y = 37, w = 85, h = 9 },
        dst = { x = 1130, y = 618, w = 4 * 85, h = 4 * 9 },
    }),

    tall_e = make_mirror({
        src = { x = 0, y = 37, w = 85, h = 9 },
        dst = { x = 1130, y = 618, w = 4 * 85, h = 4 * 9 },
    }),

    tall_pie = make_mirror({
        src = { x = 0, y = 15958, w = 340, h = 426 },
        dst = { x = 1130, y = 654, w = 340, h = 426 },
    }),

    eye_measure = make_mirror({
        src = { x = 155, y = 7902, w = 30, h = 580 },
        dst = { x = 0, y = 370, w = 790, h = 340 },
    }),
}

local make_image = function(path, dst)
    local this = nil

    return function(enable)
        if enable and not this then
            this = waywall.image(path, dst)
        elseif this and not enable then
            this:close()
            this = nil
        end
    end
end

local images = {
    measuring_overlay = make_image(overlay_path, {
        dst = { x = 0, y = 370, w = 790, h = 340 },
    }),
}

local show_mirrors = function(thin, tall, wide)
    mirrors.thin_e(thin)

    mirrors.tall_e(tall)
    mirrors.tall_pie(tall)

    mirrors.eye_measure(tall)
    images.measuring_overlay(tall)
end

local thin_enable = function()
    show_mirrors(true, false, false)
    waywall.set_sensitivity(normal_sens)
end

local tall_enable = function()
    show_mirrors(false, true, false)
    waywall.set_sensitivity(tall_sens)
end
local wide_enable = function()
    show_mirrors(false, false, true)
    waywall.set_sensitivity(normal_sens)
end

local res_disable = function()
    show_mirrors(false, false, false)
    waywall.set_sensitivity(normal_sens)
end


-- RESOLUTIONS --
local make_res = function(width, height, enable, disable)
    return function()
        local active_width, active_height = waywall.active_res()

        if active_width == width and active_height == height then
            waywall.set_resolution(0, 0)
            disable()
        else
            waywall.set_resolution(width, height)
            enable()
        end
    end
end

local resolutions = {
    thin = make_res(340, 1440, thin_enable, res_disable),
    tall = make_res(340, 16384, tall_enable, res_disable),
    wide = make_res(2560, 340, wide_enable, res_disable),
}

config.actions = {
    ["F4"] = resolutions.thin,
    ["F5"] = resolutions.tall,
    ["F6"] = resolutions.wide,

    ["Shift-Delete"] = function()
        ensure_ninjabrain()
        helpers.show_floating()
    end,
    ["*-Delete"] = function()
        helpers.toggle_floating()
    end
}

return config
