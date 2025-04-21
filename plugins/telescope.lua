local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
	defaults = {
		prompt_prefix = " ", -- Add a nice icon
		selection_caret = " ", -- Add a caret icon
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
		file_ignore_patterns = { "node_modules", "%.git/" },
	},
	pickers = {
		find_files = {
			theme = "dropdown",
			previewer = false, -- Disable preview if unnecessary
		},
	},
	extensions = {
		file_browser = {
			theme = "ivy", -- Use any theme like ivy, dropdown, or cursor
			hijack_netrw = true, -- Disable netrw and use Telescope for browsing
		},
	}, }

require('telescope').load_extension('file_browser')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<CR>', { noremap = true, silent = true })

