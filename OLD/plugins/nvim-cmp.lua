-- auto complete (cmp)
-- ~/.config/nvim/lua/plugins/cmp.lua
return {
	-- Step 1: Define plugins
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" }, -- Optional: for buffer completions
	{ "L3MON4D3/LuaSnip" }, -- Optional: for snippets
	{ "saadparwaiz1/cmp_luasnip" }, -- Optional: luasnip integration

	-- Step 2: Configure nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert,noselect",
				},
				preselect = cmp.PreselectMode.Item, -- Auto-select first item
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For luasnip
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
