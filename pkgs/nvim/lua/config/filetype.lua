local M = {}

function M.setup()
	vim.g.did_load_filetypes = 1

	require("filetype").setup {
		overrides = {
			literal = {
				direnvrc = "zsh";
				Berksfile = "ruby"
			},
		},
	}

end

return M
