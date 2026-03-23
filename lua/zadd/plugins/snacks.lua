return {
    "folke/snacks.nvim",
    priority = 2000,
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    ---@type snacks.Config
    opts = {
        input = { enabled = true },
        image = { enabled = true },
        quickfile = { enabled = true },
        picker = { enabled = true },
        explorer = { enabled = true },
        dashboard = {
            enabled = true,
            sections = {
                { section = "startup", padding = { 2, 2 } },
                {
                    function()
                        local ascii_art = require("zadd.homebrown.alphas")

                        if vim.loop.cwd():find("^/home/zadd/Programming/Advent_of_Code") then
                            return { text = ascii_art.aoc:random() }
                        else
                            return { text = ascii_art.general:random() }
                        end
                    end,
                    align = "center",
                },
                { section = "keys", gap = 1, padding = 1, align = "center" },
            },
        },
    },
    keys = {
        -- stylua: ignore start
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fcc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File for Neovim" },
        { "<leader>fch", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") .. "/../hypr" }) end, desc = "Find Config File for Hyprland" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
        { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
        { "<leader>fs", function() Snacks.picker.grep() end, desc = "Buffer lines" },

        { "<leader>pp", function() Snacks.toggle.profiler() end, desc = "Toggle Profiler" },
        { "<leader>ph", function() Snacks.toggle.profiler_highlights() end, desc = "Toggle Profiler Highlights" },
        { "<leader>ps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },

        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        -- stylua: ignore end
    },
    init = function()
        _G.dd = function(...)
            Snacks.debug.inspect(...)
        end
        _G.bt = function()
            Snacks.debug.backtrace()
        end
        vim._print = _G.dd
    end,
}
