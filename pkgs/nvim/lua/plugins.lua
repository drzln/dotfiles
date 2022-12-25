-- plugin declarations
local M = {}

function M.setup()
	local packer_bootstrap = false

	-- packer plugin manager configuration
	local conf = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	}

	-- main packer plugin loading initialization
	local function packer_init()
		local fn = vim.fn
		local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
		if fn.empty(fn.glob(install_path)) > 0 then
			packer_bootstrap = fn.system({
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
			})
			vim.cmd([[packadd packer.nvim]])
		end
		vim.cmd("autocmd BufWritePost plugins.lua source <afile> || PackerCompile")
	end

	-- function containing plugin declarations matching packer
	local function plugins(use)
		-- the packer lua plugin manager for neovim
		use({
			"wbthomason/packer.nvim",
			disable = false,
		})

		-- extra lua development	functions
		use({
			"nvim-lua/plenary.nvim",
			disable = false,
		})

		-- theme
		use({
			"shaunsingh/nord.nvim",
			disable = false,
			config = function()
				vim.cmd([[colorscheme nord]])
			end,
		})

		-- improve startup time
		--[[ use({ ]]
		--[[ 	"lewis6991/impatient.nvim", ]]
		--[[ 	disable = false, ]]
		--[[ }) ]]

		-- treesitter
		--[[ use({ ]]
		--[[ 	"nvim-treesitter/nvim-treesitter", ]]
		--[[ 	disable = false, ]]
		--[[ 	run = ":TSUpdate", ]]
		--[[ 	config = function() ]]
		--[[ 		require("nvim-treesitter.configs").setup({ ]]
		--[[ 			context_commentstring = { ]]
		--[[ 				enable = true, ]]
		--[[ 			}, ]]
		--[[ 		}) ]]
		--[[ 	end, ]]
		--[[ }) ]]

		-- development utilities
		--[[ use({ ]]
		--[[ 	"tpope/vim-rhubarb", ]]
		--[[ 	disable = false, ]]
		--[[ }) ]]

		--[[ use({ ]]
		--[[ 	"tpope/vim-fugitive", ]]
		--[[ 	event = "BufRead", ]]
		--[[ 	disable = false, ]]
		--[[ }) ]]

		--[[ use({ ]]
		--[[ 	"tpope/vim-surround", ]]
		--[[ 	event = "BufRead", ]]
		--[[ 	disable = false ]]
		--[[ }) ]]

		--[[ use({ ]]
		--[[ 	"tpope/vim-dispatch", ]]
		--[[ 	disable = false, ]]
		--[[ 	opt = true, ]]
		--[[ 	cmd = { "Dispatch", "Make", "Focus", "Start" }, ]]
		--[[ }) ]]

		use({
			"numToStr/Comment.nvim",
			disable = false,
			config = function()
				require("config.Comment").setup()
			end,
			requires = {
				"JoosepAlviste/nvim-ts-context-commentstring",
				"nvim-treesitter/nvim-treesitter",
			},
		})

		-- statusline
		use({
			"nvim-tree/nvim-web-devicons",
			disable = false,
			config = function()
				require("config.nvim-web-devicons").setup()
			end,
		})

		-- lualine
		use({
			"nvim-lualine/lualine.nvim",
			disable = false,
			requires = {
				"nvim-tree/nvim-web-devicons",
				opt = true,
			},
			config = function()
				require("config.lualine").setup()
			end,
		})

		use({ "williamboman/mason.nvim" })
		use({ "williamboman/mason-lspconfig.nvim" })
		use({ "mfussenegger/nvim-dap" })
		use({
			"jose-elias-alvarez/null-ls.nvim",
			disable = false,
			config = function()
				require("config.null-ls").setup()
			end
		})
		use({
			"neovim/nvim-lspconfig",
			config = function()
				require("lsp").setup()
			end,
		})

		--[[ use( ]]
		--[[ 	{ ]]
		--[[ 		"folke/neodev.nvim", ]]
		--[[ 		disable = false, ]]
		--[[ 	} ]]
		--[[ ) ]]


		use({
			"ray-x/lsp_signature.nvim",
			disable = false,
		})

		-- completion
		use({
			"hrsh7th/nvim-cmp",
			disable = false,
			config = function()
				require("config.nvim-cmp").setup()
			end,
		})

		-- completion sources
		use({
			"hrsh7th/cmp-nvim-lsp",
			disable = false,
		})

		use({
			"hrsh7th/cmp-buffer",
			disable = false,
		})

		use({
			"hrsh7th/cmp-path",
			disable = false,
		})

		use({
			"hrsh7th/cmp-cmdline",
			disable = false,
		})

		use({
			"amarakon/nvim-cmp-buffer-lines"
		})

		use({
			"hrsh7th/cmp-calc"
		})

		use({
			"uga-rosa/cmp-dictionary"
		})

		use({
			"dmitmel/cmp-digraphs"
		})

		use({
			"hrsh7th/cmp-omni"
		})

		use({
			"f3fora/cmp-spell"
		})

		use({
			"hrsh7th/cmp-nvim-lsp-document-symbol"
		})

		use({
			"hrsh7th/cmp-nvim-lsp-signature-help"
		})

		use({
			"petertriho/cmp-git"
		})

		use({
			"davidsierradz/cmp-conventionalcommits"
		})

		use({
			"Dosx001/cmp-commit"
		})

		use({
			"dmitmel/cmp-cmdline-history"
		})

		use({
			"lukas-reineke/cmp-rg"
		})

		use({
			"andersevenrud/cmp-tmux"
		})

		use({
			"tamago324/cmp-zsh"
		})

		use({
			"Saecki/crates.nvim"
		})

		use({
			"David-Kunz/cmp-npm"
		})

		use({
			"crispgm/cmp-beancount"
		})

		use({
			"vappolinario/cmp-clippy"
		})

		use({
			"tzachar/cmp-tabnine",
			disable = true
		})

		use({
			"jcha0713/cmp-tw2css"
		})

		use({
			"nat-418/cmp-color-names.nvim"
		})

		use({
			"hrsh7th/cmp-copilot"
		})

		use({
			"delphinus/cmp-ctags"
		})

		use({
			"rcarriga/cmp-dap"
		})

		use({
			"hrsh7th/cmp-emoji"
		})

		use({
			"max397574/cmp-greek"
		})

		use({
			"octaltree/cmp-look"
		})

		use({
			"hrsh7th/cmp-nvim-lua"
		})

		use({
			"nvim-orgmode/orgmode"
		})

		use({
			"KadoBOT/cmp-plugins"
		})

		use({
			"ray-x/cmp-treesitter"
		})

		use({
			"kristijanhusak/vim-dadbod-completion"
		})

		use({
			"pontusk/cmp-vimwiki-tags"
		})

		use({
			"codybuell/cmp-lbdb"
		})

		use({
			"amarakon/nvim-cmp-fonts"
		})

		use({
			"magicmonty/sonicpi.nvim"
		})

		use({
			"uga-rosa/cmp-dynamic"
		})

		-- key menu
		use({
			"folke/which-key.nvim",
			disable = false,
			config = function()
				require("config.whichkey").setup()
			end,
		})

		-- auto resize windows
		use({
			"camspiers/animate.vim",
			disable = false,
		})

		use({
			"camspiers/lens.vim",
			disable = false,
		})

		-- snips
		use({
			"L3MON4D3/LuaSnip",
			disable = false,
		})

		use({
			"saadparwaiz1/cmp_luasnip",
			disable = false,
		})

		-- telescope
		use({
			"nvim-telescope/telescope.nvim",
			disable = false,
		})

		use({
			"nvim-telescope/telescope-dap.nvim",
			disable = false,
		})

		use({
			"LnL7/vim-nix",
			disable = false
		})

		use({
			"nathom/filetype.nvim",
			disable = false,
			config = function()
				require("config.filetype").setup()
			end,
		})

		-- debug adapter
		--[[ use({ ]]
		--[[ "mfussenegger/nvim-dap", ]]
		--[[ 	disable = false, ]]
		--[[ 	opt = true, ]]
		--[[ 	event = "BufReadPre", ]]
		--[[ 	module = { "dap" }, ]]
		--[[ 	wants = { ]]
		--[[ 		"nvim-dap-virtual-text", ]]
		--[[ 		"DAPInstall.nvim", ]]
		--[[ 		"nvim-dap-ui", ]]
		--[[ 		"nvim-dap-python", ]]
		--[[ 	}, ]]
		--[[ 	requires = { ]]
		--[[ 		"ravenxrz/DAPInstall.nvim", ]]
		--[[ 		"theHamsta/nvim-dap-virtual-text", ]]
		--[[ 		"rcarriga/nvim-dap-ui", ]]
		--[[ 		"mfussenegger/nvim-dap-python", ]]
		--[[ 		"nvim-telescope/telescope-dap.nvim", ]]
		--[[ 		{ "leoluz/nvim-dap-go", module = "dap-go" }, ]]
		--[[ 		{ "jbyuki/one-small-step-for-vimkind", module = "osv" }, ]]
		--[[ 	}, ]]
		--[[ 	config = function() ]]
		--[[ 		require("config.dap").setup() ]]
		--[[ 	end, ]]
		--[[ }) ]]

		-- make sure packer is installed
		if packer_bootstrap then
			print("Restart Neovim required after installation")
			require("packer").sync()
		end
	end

	packer_init()

	local packer = require("packer")
	packer.init(conf)
	packer.startup(plugins)
end

return M
