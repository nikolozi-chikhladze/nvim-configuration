-- Add the parent of 'config' to Lua's package.path
local config_root = vim.fn.stdpath("config") .. "/?.lua;" .. vim.fn.stdpath("config") .. "/?/init.lua"
package.path = config_root .. ";" .. package.path

-- Add the parent of 'plugins' to Lua's package.path
local plugins_root = vim.fn.stdpath("config") .. "/plugins/?.lua;" .. vim.fn.stdpath("config") .. "/plugins/?/init.lua"
package.path = plugins_root .. ";" .. package.path

-- Ensure ['config', 'plugins'] folders is in runtime path
vim.opt.rtp:append(vim.fn.stdpath("config"))
vim.opt.rtp:append(vim.fn.stdpath("config") .. "/plugins")

-- Load configurations
require('config.globals')
require('config.options')
require('config.window_options')
require('config.mappings')

-- Load plugins
require('plugins.init')

