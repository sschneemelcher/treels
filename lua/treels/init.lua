local source = {}

source.new = function()
  local self = setmetatable({}, { __index = source })
  return self
end

source.get_trigger_characters = function()
  return { [[:alnum:]] }
end

source.complete = function(self, params, callback)
    self.items = { 
        { word = 'TEST'; label = 'TEST 🌳'; insertText = 'TEST'; filterText = 'TEST' };
    }

    callback(self.items)
end

return source

