return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    -- config = function()
    --     require('telescope').setup({})

    --     local builtin = require('telescope.builtin')
    --     vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    --     vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    --     vim.keymap.set('n', '<leader>pws', function()
    --         local word = vim.fn.expand("<cword>")
    --         builtin.grep_string({ search = word })
    --     end)
    --     vim.keymap.set('n', '<leader>pWs', function()
    --         local word = vim.fn.expand("<cWORD>")
    --         builtin.grep_string({ search = word })
    --     end)
    --     vim.keymap.set('n', '<leader>ps', function()
    --         builtin.grep_string({ search = vim.fn.input("Grep > ") })
    --     end)
    --     vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    -- end

    config = function()
        require('telescope').setup {
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            path_display = { 'truncate' },
            -- windblend = 0,
            borders = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            extensions = {
                -- fzy_native = {
                --     override_generic_sorter = false,
                --     override_file_sorter = true,
                -- },

                bibtex = {
                    -- Depth for the *.bib file
                    depth = 1,
                    -- Custom format for citation label
                    custom_formats = {},
                    -- Format to use for citation label.
                    -- Try to match the filetype by default, or use 'plain'
                    format = '',
                    -- Path to global bibliographies (placed outside of the project)
                    global_files = { '~/Zotero/bibliography/' },
                    -- Define the search keys to use in the picker
                    search_keys = { 'author', 'year', 'title' },
                    -- Template for the formatted citation
                    citation_format = '{{author}} ({{year}}), {{title}}, {{doi}}.',
                    -- Only use initials for the authors first name
                    citation_trim_firstname = true,
                    -- Max number of authors to write in the formatted citation
                    -- following authors will be replaced by "et al."
                    citation_max_auth = 2,
                    -- Context awareness disabled by default
                    context = true,
                    -- Fallback to global/directory .bib files if context not found
                    -- This setting has no effect if context = false
                    context_fallback = true,
                    -- Wrapping in the preview window is disabled by default
                    wrap = false,
                },
                -- tele_tabby = {
                --     use_higlighter = true,
                -- },

                persisted = {
                },
            }
        }

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
}
