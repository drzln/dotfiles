local M = {}

function M.setup()
	vim.cmd [[set completeopt=menu,menuone,noselect]]


	local cmp = require("cmp")
	local map = require("utils.map")

	cmp.setup(
		{
			-- snippet = {
			-- 	expand = function(args)
			-- 		require('luasnip').lsp_expand(args.body)
			-- 	end,
			-- },
			mapping = {
				['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
				['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
				['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
				['<C-y>'] = cmp.config.disable,
				['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close(), }),
				['<CR>'] = cmp.mapping.confirm({ select = true }),
				['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
				['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
			},
			sources = cmp.config.sources(
				{
					{ name = 'nvim_lsp' },
					--[[ { name = 'buffer' }, ]]
					--[[ { name = 'luasnip' }, ]]
				}
			)
		}
	)

	-- with only the mappings above when you press c-n on insert with nothing inserted
	-- it brings up the ins-completion native from neovim while you want to do cmp.complete()
	-- instead as if you did C-Space
	map('i', '<c-n>', "<cmd>lua require('cmp').complete()<CR>", {
		noremap = false, expr = false
	})
end

return M
