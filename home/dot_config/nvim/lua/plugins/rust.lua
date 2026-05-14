-- Rust development plugins
return {
  -- rustaceanvim - Enhanced Rust tooling (successor to rust-tools.nvim)
  -- Manages rust-analyzer LSP automatically, do NOT configure rust_analyzer in lsp.lua
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    -- vim.g.rustaceanvim must be set before the ftplugin loads
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = {
            auto_focus = true,
          },
          inlay_hints = {
            auto = true,
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
          },
        },
        server = {
          on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, silent = true }

            -- Rust-specific keymaps
            vim.keymap.set("n", "<leader>ra", function() vim.cmd.RustLsp("codeAction") end,
              vim.tbl_extend("force", opts, { desc = "Rust code action" }))
            vim.keymap.set("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end,
              vim.tbl_extend("force", opts, { desc = "Rust debuggables" }))
            vim.keymap.set("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end,
              vim.tbl_extend("force", opts, { desc = "Rust runnables" }))
            vim.keymap.set("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end,
              vim.tbl_extend("force", opts, { desc = "Rust testables" }))
            vim.keymap.set("n", "<leader>rm", function() vim.cmd.RustLsp("expandMacro") end,
              vim.tbl_extend("force", opts, { desc = "Rust expand macro" }))
            vim.keymap.set("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end,
              vim.tbl_extend("force", opts, { desc = "Open Cargo.toml" }))
            vim.keymap.set("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end,
              vim.tbl_extend("force", opts, { desc = "Rust parent module" }))
            vim.keymap.set("n", "<leader>rj", function() vim.cmd.RustLsp("joinLines") end,
              vim.tbl_extend("force", opts, { desc = "Rust join lines" }))
            vim.keymap.set("n", "<leader>re", function() vim.cmd.RustLsp("explainError") end,
              vim.tbl_extend("force", opts, { desc = "Rust explain error" }))
            vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end,
              vim.tbl_extend("force", opts, { desc = "Rust hover actions" }))

            -- Standard LSP keymaps (same as your lsp.lua LspAttach)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
            vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
            vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format({ async = true }) end,
              vim.tbl_extend("force", opts, { desc = "Format document" }))
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
        dap = {
          adapter = function()
            local codelldb_path = vim.fn.exepath("codelldb")
            if codelldb_path ~= "" then
              return require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, "")
            end
          end,
        },
      }
    end,
  },

  -- crates.nvim - Manage Cargo.toml dependencies
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local crates = require("crates")
      crates.setup({
        popup = {
          border = "rounded",
          show_version_date = true,
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })

      -- Crates.nvim keymaps (only in Cargo.toml)
      vim.api.nvim_create_autocmd("BufRead", {
        pattern = "Cargo.toml",
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          vim.keymap.set("n", "<leader>ct", crates.toggle, vim.tbl_extend("force", opts, { desc = "Toggle crate info" }))
          vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, vim.tbl_extend("force", opts, { desc = "Show crate versions" }))
          vim.keymap.set("n", "<leader>cf", crates.show_features_popup, vim.tbl_extend("force", opts, { desc = "Show crate features" }))
          vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, vim.tbl_extend("force", opts, { desc = "Show crate dependencies" }))
          vim.keymap.set("n", "<leader>cu", crates.update_crate, vim.tbl_extend("force", opts, { desc = "Update crate" }))
          vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, vim.tbl_extend("force", opts, { desc = "Upgrade crate" }))
          vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, vim.tbl_extend("force", opts, { desc = "Upgrade all crates" }))
        end,
      })
    end,
  },
}
