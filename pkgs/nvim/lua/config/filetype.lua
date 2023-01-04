local M = {}

function M.setup()
	vim.g.did_load_filetypes = 1

	require("filetype").setup {
		--[[ complex statement for .envrc not working ]]
		--[[ in this form ]]
		--[[ complex = { ]]
		--[[ 	[".envrc"] = "sh" ]]
		--[[ }; ]]
		overrides = {
			literal = {
				direnvrc = "sh";
				Berksfile = "ruby";
				Capfile = "ruby";
				Vagrantfile = "ruby"
			},
		},
	}

end

return M
