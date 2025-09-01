--  alleen de config, installeer met MasonInstall basedpyright eerst.
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			basedpyright = {
				settings = {
					basedpyright = {
						typeCheckingMode = "standard",
					},
				},
			},
		},
	},
}
