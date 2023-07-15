local ts = vim.treesitter
local test = function()
    local ok, parser = pcall(require('vim.treesitter').get_parser)
    if ok then
        local query_string = '(ERROR) @err'

        local tree = parser:parse()[1]

        local query = ts.query.parse(parser:lang(), query_string)

        for _, node in query:iter_captures(tree:root(), 0, 0, -1) do
            vim.api.nvim_buf_add_highlight(0, -1, "ErrorSign", 2, 0, -1)
            -- print(node.start(node))
        end
    end
end

vim.api.nvim_create_user_command('TEST', test, {})
