---@class _BaseUI
---@field diContainer DIContainer
---@field mainUI ScreenGui
---@field isOpen boolean
local _BaseUI = {}
_BaseUI.__index = _BaseUI   

---@param diContainer DIContainer
---@return _BaseUI
function _BaseUI.new(diContainer)
    local self = setmetatable({}, _BaseUI)
    self.isOpen = false
    self.diContainer = diContainer
    return self
end

function _BaseUI:init()
    ---@type ClientApp
    local application = self.diContainer:resolve("Application")
    local playerService = application.services.playerService
    self.mainUI = playerService.player.PlayerGui:WaitForChild("MainUI")
end

function _BaseUI:close()
    error("Not implemented")
end

function _BaseUI:open()
    error("Not implemented")
end

function _BaseUI:toggle()
    warn("toggle")
    self.isOpen = not self.isOpen
    warn(self.isOpen)
    if self.isOpen then
        self:close()
    else
        self:open()
    end
end

return _BaseUI