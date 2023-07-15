local queries = require('treels.langs')
local ts = vim.treesitter
local source = {}

source.new = function()
  local self = setmetatable({}, { __index = source })
  return self
end

source.get_trigger_characters = function()
  return { [[a-z]] }
end

source.complete = function(self, params, callback)
    local ok, parser = pcall(require('vim.treesitter').get_parser)

    if not ok then
        return
    end

    local query_string = queries[parser:lang()]

    if not query_string then
        return
    end

    local tree = parser:parse()[1]

    local query = ts.query.parse(parser:lang(), query_string) self.items = {}

    for _, node in query:iter_captures(tree:root(), 0, 0, -1) do
        local name = ts.get_node_text(node, 0)
        local kind = node.type(node.parent(node)):match('^(.*)_')
        table.insert(self.items, {
            label = name,
            cmp = { kind_text = kind },
            insertText = name,
            filterText = name,
        })
    end

    callback(self.items)
end

return source
