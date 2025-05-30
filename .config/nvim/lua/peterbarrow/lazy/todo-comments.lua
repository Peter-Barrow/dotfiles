return {
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",

        config = function()
            require('todo-comments').setup({})

            vim.keymap.set("n", "<leader>tc", "<cmd>TodoTrouble toggle win.position=left<cr>")

            vim.keymap.set("n", "<leader>tC", "<cmd>TodoTrouble toggle filter.buf=0 win.position=left<cr>")

            vim.keymap.set("n", "]t", function()
                require("todo-comments").jump_next()
            end, { desc = "Next todo comment" })

            vim.keymap.set("n", "[t", function()
                require("todo-comments").jump_prev()
            end, { desc = "Previous todo comment" })
        end

    },
}
