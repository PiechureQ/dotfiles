local _border = "rounded"
local telescope = require("telescope.builtin")

vim.diagnostic.config({ float = { border = _border } })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = _border,
})

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(server_name)
  return function(_, bufnr)
    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
      vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>af", function()
      vim.lsp.buf.code_action({ apply = true })
    end, "[C]ode [A]ction")
    nmap("<leader>F", vim.cmd.Format, "[F]ormat buffer")

    -- See `:help K` for why this keymap
    nmap("K", function()
      vim.lsp.buf.hover()
    end, "Hover Documentation")
    nmap("<C-k>", function()
      vim.lsp.buf.signature_help()
    end, "Signature Documentation")

    -- go to lsp items
    nmap("gd", telescope.lsp_definitions, "[G]oto [D]efinition")
    nmap("gr", telescope.lsp_references, "[G]oto [R]eferences")
    nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("gy", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("gs", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    nmap("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")

    -- Diagnostic keymaps
    -- nmap("[d", vim.diagnostic.goto_prev, "Diagnostics previous item")
    -- nmap("]d", vim.diagnostic.goto_next, "Diagnostics next item")
    nmap("<leader>e", vim.diagnostic.open_float, "Open error floating window")

    nmap("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- typescript specific mapings
    if server_name == "ts_ls" then
      -- vim.keymap.set("n", "<leader>gs", function()
      --   local fname = vim.fn.expand("%")
      --   if string.find(fname, "tsx") then
      --     vim.cmd("e " .. string.gsub(fname, "tsx", "scss"))
      --   end
      -- end, { desc = "[G]oto [S]tyle source" })

      local function organize_imports()
        -- gets the current bufnr if no bufnr is passed
        if not bufnr then
          bufnr = vim.api.nvim_get_current_buf()
        end

        -- params for the request
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(bufnr) },
          title = "",
        }

        -- perform a syncronous request
        -- 500ms timeout depending on the size of file a bigger timeout may be needed
        vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", params, 500)
      end

      nmap("<leader>ai", organize_imports, "Code [A]ction organize [I]mports")
    end
  end
end

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
-- Add any additional override configuration in the following tables. They will be passed to
-- the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  ts_ls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

-- mason_lspconfig.setup_handlers({
--   function(server_name)
--     require("lspconfig")[server_name].setup({
--       capabilities = capabilities,
--       on_attach = on_attach(server_name),
--       settings = servers[server_name],
--       filetypes = (servers[server_name] or {}).filetypes,
--     })
--   end,
-- })
