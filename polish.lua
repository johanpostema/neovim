-- detect ansible playbook automaticall
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"yaml"},
  callback = function()
    local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, 10, false), "\n") or ""
    if
      string.match(text, "-%s+hosts:")
      or string.match(text, "tasks:")
      or string.match(text, "roles:")
      or string.match(text, "-%s+name:")
    then
      vim.bo.filetype = "yaml.ansible"
    end
  end,
  group = vim.api.nvim_create_augroup("AnsibleFiletypeOverride", { clear = true }),
})

-- Re-check filetype on buffer write or text change
vim.api.nvim_create_autocmd({"BufWritePost", "TextChanged", "TextChangedI"}, {
  pattern = {"*.yml", "*.yaml"},
  callback = function()
    local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, 10, false), "\n") or ""
    local current_ft = vim.bo.filetype
    if
      (string.match(text, "-%s+hosts:")
      or string.match(text, "tasks:")
      or string.match(text, "roles:")
      or string.match(text, "-%s+name:"))
      and current_ft ~= "yaml.ansible"
    then
      vim.bo.filetype = "yaml.ansible"
    elseif
      not (string.match(text, "-%s+hosts:")
      or string.match(text, "tasks:")
      or string.match(text, "roles:")
      or string.match(text, "-%s+name:"))
      and current_ft == "yaml.ansible"
    then
      vim.bo.filetype = "yaml"
    end
  end,
  group = vim.api.nvim_create_augroup("AnsibleFiletypeDynamic", { clear = true }),
})
