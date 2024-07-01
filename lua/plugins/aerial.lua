return {
  "stevearc/aerial.nvim",
  opts = {
    lsp = {
      priority = {
        -- disabling pylsp to provide breadcrumbs as they didn't give heirachical support
        pylsp = -1
      }
    }
  }
}
