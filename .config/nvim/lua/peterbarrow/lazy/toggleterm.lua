return {
    'akinsho/toggleterm.nvim',
    name="toggleterm",
    version = "*",
    -- config = true,

    config = function ()
        local toggleterm = require("toggleterm")

        toggleterm.setup ({
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.27
                end
            end,
            open_mapping = '<leader>tt',
            shade_terminals = true,
            shading_factor = 0.9,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            direction = 'horizontal',
            auto_scroll = true,
        })
    end,

    vim.keymap.set('n', '<leader>tv', '<CMD>ToggleTerm size=65 direction=vertical<CR>')
}


