local query_for_lang = {
    lua = [[
        (assignment_statement 
            (variable_list 
                name: (identifier) @name))
    ]]
}

return query_for_lang
