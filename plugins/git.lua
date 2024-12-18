require('gitsigns').setup {
	signs                        = {
		add          = { text = '┃' },
		change       = { text = '┃' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
	signs_staged                 = {
		add          = { text = '┃' },
		change       = { text = '┃' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
	signs_staged_enable          = true,
	signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl                        = true, -- Toggle with `:Gitsigns toggle_numhl`
	linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir                 = {
		follow_files = true
	},
	auto_attach                  = true,
	attach_to_untracked          = false,
	current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts      = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
		use_focus = true,
	},
	current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
	sign_priority                = 6,
	update_debounce              = 100,
	status_formatter             = nil, -- Use default
	max_file_length              = 40000, -- Disable if file is longer than this (in lines)
	preview_config               = {
		-- Options passed to nvim_open_win
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
	on_attach                    = function(bufnr)
		local function map(mode, lhs, rhs, opts)
			opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
			vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
		end

		-- Blames
		map('n', '<Leader>gb', ":Gitsigns blame<CR>", { noremap = true, silent = true })
		map('n', '<Leader>gtb', ":Gitsigns toggle_current_line_blame<CR>", { noremap = true, silent = true })

		-- Hunks
		map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
		map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
		map('n', '<Leader>ghs', ":Gitsigns stage_hunk<CR>", { noremap = true, silent = true })
		map('n', '<Leader>ghr', ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true })
		map('n', '<Leader>ghp', ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true })

		-- Diffs
		map('n', '<Leader>gdf', ":Gitsigns diffthis<CR>", { noremap = true, silent = true })

		-- Text object
		map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
		map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
	end
}
