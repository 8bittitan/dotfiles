return {
  root_dir = function(bufnr, on_dir)
    local path = vim.api.nvim_buf_get_name(bufnr)

    if vim.fs.find('buf.yaml', { path = path, upward = true })[1] then
      return
    end

    local root = vim.fs.root(bufnr, { 'buf.yaml', 'buf.gen.yaml', '.git' })
    if root then
      on_dir(root)
    end
  end,
}
