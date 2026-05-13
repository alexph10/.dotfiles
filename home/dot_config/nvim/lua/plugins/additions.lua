-- Additions layered on top of the existing config from the dotfiles repo.
-- which-key, indent-blankline, gitsigns are intentionally NOT here -- they already
-- live in ui.lua and git.lua. This file only adds lazygit.nvim and conform.nvim.
return {
    -- LazyGit floating UI (uses the lazygit binary; install via winget/scoop/brew).
    {
        "kdheepak/lazygit.nvim",
        cmd  = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>",            desc = "LazyGit" },
            { "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit (file history)" },
        },
    },

    -- Format-on-save via conform.nvim, wired to the formatters you already install via Mason.
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd   = { "ConformInfo" },
        keys  = {
            {
                "<leader>F",
                function() require("conform").format({ async = true, lsp_fallback = true }) end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
                local skip = { ["bigfile"] = true, ["oil"] = true }
                if skip[vim.bo[bufnr].filetype] then return end
                return { timeout_ms = 1500, lsp_fallback = true }
            end,
            formatters_by_ft = {
                lua             = { "stylua" },
                python          = { "isort", "black" },
                javascript      = { "prettier" },
                typescript      = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                vue             = { "prettier" },
                svelte          = { "prettier" },
                css             = { "prettier" },
                scss            = { "prettier" },
                html            = { "prettier" },
                json            = { "prettier" },
                jsonc           = { "prettier" },
                yaml            = { "prettier" },
                markdown        = { "prettier" },
                graphql         = { "prettier" },
                rust            = { "rustfmt" },
                go              = { "gofmt" },
                sh              = { "shfmt" },
                bash            = { "shfmt" },
                zsh             = { "shfmt" },
                c               = { "clang_format" },
                cpp             = { "clang_format" },
                toml            = { "taplo" },
            },
            formatters = {
                shfmt = { prepend_args = { "-i", "4", "-ci" } },
                prettier = { prepend_args = { "--print-width", "100", "--single-quote", "--trailing-comma", "all" } },
            },
        },
        init = function()
            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then vim.b.disable_autoformat = true
                else              vim.g.disable_autoformat = true
                end
            end, { desc = "Disable autoformat (use ! for buffer only)", bang = true })

            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, { desc = "Re-enable autoformat" })
        end,
    },
}
