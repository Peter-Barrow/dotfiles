return {
    "MIBismuth/matlab.nvim",

    config = function()
        require('matlab').setup({
            matlab_dir = "~/Applications/MATLAB/bin/matlab"
        })

        -- Keymaps
        vim.api.nvim_set_keymap('n', '<leader>mo', ':MatlabCliOpen<CR>', {})
        vim.api.nvim_set_keymap('n', '<leader>mc', ':MatlabCliCancelOperation<CR>', {})
        vim.api.nvim_set_keymap('n', '<leader>mh', ':MatlabHelp<CR>', {})
        vim.api.nvim_set_keymap('n', '<leader>md', ':MatlabDoc<CR>', {})
        vim.api.nvim_set_keymap('n', '<leader>me', ':MatlabOpenEditor<CR>', {})
        vim.api.nvim_set_keymap('v', '<leader>mr', ':<C-u>execute "MatlabCliRunSelection"<CR>', {})
        vim.api.nvim_set_keymap('n', '<leader>mw', ':MatlabOpenWorkspace<CR>', {})
        vim.api.nvim_set_keymap('n', '<leader><CR>', ':MatlabCliRunCell<CR>', {})
    end
}
