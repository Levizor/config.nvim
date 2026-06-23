return {
    {
        "rmagatti/auto-session",
        lazy = false,
        opts = {
            auto_save_enabled = true,
            auto_restore_enabled = true,
            suppressed_dirs = { "~/", "~/Downloads", "~/Desktop", "/tmp", "/nix" },
            bypass_session_save_file_types = { "alpha", "dashboard", "oil" },

            session_lens = {
                picker = "snacks",
                mappings = {
                    delete_session = { "i", "<C-d>" },
                    alternate_session = { "i", "<C-s>" },
                    copy_session = { "i", "<C-y>" },
                },
            }
        },
        config = function(_, opts)
            vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

            require("auto-session").setup(opts)
        end,
    },
}
