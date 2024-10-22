return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },

        config = function()
            local ufo = require("ufo")

            vim.o.foldcolumn = '0' -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.fillchars = [[eob: ,fold: ,foldopen:🞃,foldsep: ,foldclose:🞂]]

            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 🢇 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }
            local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
            for _, ls in ipairs(language_servers) do
                require('lspconfig')[ls].setup({
                    capabilities = capabilities
                    -- you can add other fields for setting up lsp server in this table
                })
            end

            ufo.setup({
                -- provider_selector = function(bufnr, filetype, buftype)
                --     return {'treesitter', 'indent'}
                -- end,
                open_fold_hl_timeout = 400,
                close_fold_kinds_for_ft = {
                    default = { 'imports', 'comment' },
                    c = { 'comment', 'region' }
                },
                fold_virt_text_handler = handler,
                preview = {
                    win_config = {
                        border = "rounded",
                        -- border = { "╭", "-", "╮", "│", "╯", "-", "╰", "|" },
                        -- winhighlight = 'Normal:Folded',
                        winblend = 0
                    },
                    mappings = {
                        scrollU = '<C-u>',
                        scrollD = '<C-d>',
                        jumpTop = '[',
                        jumpBot = ']'
                    }
                },
            })

            vim.keymap.set('n', 'zR', ufo.openAllFolds)
            vim.keymap.set('n', 'zM', ufo.closeAllFolds)

            vim.keymap.set('n', 'K', function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    -- choose one of coc.nvim and nvim lsp
                    -- vim.fn.CocActionAsync('definitionHover') -- coc.nvim
                    vim.lsp.buf.hover()
                end
            end)

            -- Jump to closed folds
            vim.cmd [[
                  function! NextClosedFold(dir)
                  let cmd = 'norm!z'..a:dir
                  let view = winsaveview()
                  let [l0, l, open] = [0, view.lnum, 1]
                  while l != l0 && open
                      exe cmd
                      let [l0, l] = [l, line('.')]
                      let open = foldclosed(l) < 0
                  endwhile
                  if open
                      call winrestview(view)
                  endif
                  endfunction
                  function! RepeatCmd(cmd) range abort
                      let n = v:count < 1 ? 1 : v:count
                      while n > 0
                          exe a:cmd
                          let n -= 1
                      endwhile
                  endfunction
                ]]

            vim.keymap.set("n", "zj", ":<c-u>call RepeatCmd('call NextClosedFold(\"j\")')<cr>", { silent = true })
            vim.keymap.set("n", "zk", ":<c-u>call RepeatCmd('call NextClosedFold(\"k\")')<cr>", { silent = true })
        end
    }
}
