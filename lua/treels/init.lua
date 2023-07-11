local source = {}

source.new = function()
  local self = setmetatable({}, { __index = source })
  return self
end

source.get_trigger_characters = function()
  return { [[:alnum:]] }
end

source.complete = function(self, params, callback)
    local ok, parser = pcall(require('vim.treesitter').get_parser)

    if not ok then
        return
    end

    local tree = parser:parse()[1]
    local query_string = '(variable_declaration) @variable_declaration'
    local query = vim.treesitter.query.parse(parser:lang(), query_string)
    self.items = {}

    for _, node in query:iter_captures(tree:root(), 0, 0, -1) do
        local word = vim.treesitter.get_node_text(node, 0)

        table.insert(self.items, {
            word = word,
            label = word,
            insertText = word,
            filterText = word,
        })
    end

    callback(self.items)
end

return source
