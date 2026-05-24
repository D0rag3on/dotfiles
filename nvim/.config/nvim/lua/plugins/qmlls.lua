return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("qmlls", {
        cmd = { "/run/current-system/sw/bin/qmlls", "-E" },
        filetypes = { "qml" },
        root_markers = { "qmlproject", ".git" },
      })
      vim.lsp.enable "qmlls"
    end,
  },
}
