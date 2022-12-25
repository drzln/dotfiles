local M = {}

function M.setup(opts)
	local lsputils = require("lsp.utils")

	-- override sumneko_lua
	local sumneko_opts = lsputils.merge(
		{
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
						path = vim.split(package.path, ";"),
					},
					workspace = {
						library = {
							[vim.fn.expand "$VIMRUNTIME/lua"] = true,
							[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
						},
						maxPreload = 100000,
						preloadFileSize = 1000,
					},
					diagnostics = { globals = { "vim" } },
				}
			}
		},
		opts
	)

	-- enable sumneko_lua
	require("lspconfig").sumneko_lua.setup(sumneko_opts)
end

return M
