local Maid = {}
Maid.__index = Maid

function Maid.new()
    return setmetatable({
        Tasks = {}
    }, Maid)
end

function Maid:Give(task)
    table.insert(self.Tasks, task)
    return task
end

function Maid:Cleanup()
    for i, task in ipairs(self.Tasks) do
        local taskType = typeof(task)

        if taskType == "RBXScriptConnection" then
            if task.Connected then
                task:Disconnect()
            end

        elseif taskType == "Instance" then
            if task.Parent then
                task:Destroy()
            end

        elseif taskType == "function" then
            pcall(task)

        elseif type(task) == "table" then
            if typeof(task.Destroy) == "function" then
                pcall(function()
                    task:Destroy()
                end)
            elseif typeof(task.Cleanup) == "function" then
                pcall(function()
                    task:Cleanup()
                end)
            end
        end

        self.Tasks[i] = nil
    end
end

function Maid:Destroy()
    self:Cleanup()
end

return Maid
