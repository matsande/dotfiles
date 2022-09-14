local commands = {}

function commands.notes() 
    local notes = [[
    <space>e        - open diagnostics
    <space>rn       - rename
    <space>ca       - code actions

    gd              - goto definition
    K, gh           - hover 
    ]]
    print(notes)
end

return commands
