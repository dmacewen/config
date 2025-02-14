-- Enable true colors
if vim.fn.has('termguicolors') == 1 then
    vim.opt.termguicolors = true
end

vim.opt.showtabline = 2

-- Sonokai theme
vim.g.sonokai_style = 'shusia'
vim.g.sonokai_better_performance = 1
vim.cmd('colorscheme sonokai')

-- -- Lightline configuration
-- vim.g.lightline = {
--     colorscheme = 'sonokai',
--     active = {
--         left = {
--             { 'mode', 'paste' },
--             { 'gitbranch', 'readonly', 'filename', 'modified' }
--         }
--     },
--     tabline = {
--         left = {{'buffers'}}
--     },
--     component_function = {
--         gitbranch = 'fugitive#head'
--     },
--     component_expand = {
--         buffers = 'lightline#bufferline#buffers'
--     },
--     component_type = {
--         buffers = 'tabsel'
--     }
-- }
-- 
-- -- Bufferline configuration
-- vim.g['lightline#bufferline#show_number'] = 2
-- vim.g['lightline#bufferline#shorten_path'] = 1
-- vim.g['lightline#bufferline#unnamed'] = '[No Name]'
-- vim.g['lightline#bufferline#enable_devicons'] = 1
-- 
-- -- Make sure colorscheme is applied after setting lightline
-- vim.cmd([[
--     runtime plugin/lightline.vim
--     call lightline#enable()
-- ]])
