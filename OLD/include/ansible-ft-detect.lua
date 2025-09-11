vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufWritePost" }, {
	pattern = { "*.yml", "*.yaml" },
	callback = function()
		-- Read the first few lines of the current buffer
		local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, 50, false), "\n") or ""
		if
			string.match(text, "- hosts:")
			or string.match(text, "tasks:")
			or string.match(text, "roles:")
			or string.match(text, "- name:")
		then
			vim.bo.filetype = "yaml.ansible"
			return
		end
	end,
})
