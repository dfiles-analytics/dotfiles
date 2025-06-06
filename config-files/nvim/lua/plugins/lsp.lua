return {
	-- Mason: installs and manages LSP servers, formatters, and tools
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},

	-- Mason-LSPConfig bridge: auto-installs the configured LSP servers
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright",
					"bashls",
					"lua_ls",
					"jsonls",
					"ts_ls",
					"html",
					"cssls",
					"marksman",
					"clangd",
				},
			})
		end,
	},

	-- LSPConfig: attaches the servers to buffers
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")

			lspconfig.pyright.setup({})
			lspconfig.bashls.setup({})
			lspconfig.jsonls.setup({})
			lspconfig.ts_ls.setup({})
			lspconfig.html.setup({})
			lspconfig.cssls.setup({})
			lspconfig.marksman.setup({})
			lspconfig.clangd.setup({})

			-- Lua LSP: configure globals and runtime path
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					}
				}
			})
		end,
	},
}

