return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	-- Format on save.
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{
			"<Leader>cf",
			function()
				require("conform").format()
			end,
			mode = { "n", "v" },
			desc = "Format",
		},
		{
			"<Leader>cF",
			function()
				require("conform").format({ formatters = { "injected" } })
			end,
			mode = { "n", "v" },
			desc = "Format Injected Langs",
		},
	},
	opts = {
		default_format_opts = {
			timeout_ms = 3000,
			lsp_format = "fallback",
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
		},
		-- Custom formatters and overrides for built-in formatters.
		formatters = {
			-- Format treesitter injected languages, such as markdown code blocks.
			injected = {
				options = { ignore_errors = true },
			},
			shfmt = {
				-- Indent with 2 spaces and indent switch cases.
				prepend_args = { "-i", "2", "-ci" },
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
	end,
}
