-- Configuring CodeCompanion with OpenAI for AstroNvim
return {
	"olimorris/codecompanion.nvim",
	opts = {
		adapters = {
			http = {
				openai = require("codecompanion.adapters").extend("openai", {
					env = {
						api_key = "OPENAI_API_KEY",
					},
					schema = {
						model = {
							default = "gpt-4o-mini",
						},
					},
				}),
			},
		},
		strategies = {
			chat = {
				adapter = "openai",
			},
			inline = {
				adapter = "openai",
			},
		},
	},
}
