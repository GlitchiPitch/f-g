local _BaseUI = require(script.Parent._BaseUI)

---@class RecipeUI : _BaseUI
local RecipeUI = setmetatable({}, _BaseUI)
RecipeUI.__index = RecipeUI

---@param diContainer DIContainer
---@return RecipeUI
function RecipeUI.new(diContainer)
	local self = setmetatable(_BaseUI.new(diContainer), RecipeUI)

	return self
end

function RecipeUI:init()
	_BaseUI.init(self)

	self.recipeUI = self.mainUI.Recipe
	self.closeButton = self.recipeUI.CloseButton
	self.header = self.recipeUI.Content.Header
	self.ingredientsContainer = self.recipeUI.Content.ScrollingFrame
	self.ingredientsTemplate = self.ingredientsContainer.Template

	self:_setup()
end

function RecipeUI:toggle(recipe)
	warn(recipe)
	if self.recipeUI.Visible then
		self:close()
	else
		self:open(recipe)
	end
end

function RecipeUI:open(recipe)
	self.recipeUI.Visible = true
	self:_fillHeader(recipe)
	self:_fillIngredients(recipe)
end

function RecipeUI:close()
	self.recipeUI.Visible = false
end

function RecipeUI:_setup()
	self.closeButton.MouseButton1Click:Connect(function()
		self:close()
	end)
end

---@param recipe ItemData
function RecipeUI:_fillHeader(recipe)
	self.header.ImageLabel.Image = recipe.image
	self.header.TextLabel.Text = recipe.name
end

function RecipeUI:_fillIngredients(recipe)
	for _, ingredient in self.ingredientsContainer:GetChildren() do
		if ingredient:IsA("Frame") and ingredient.Name ~= "Template" then
			ingredient:Destroy()
		end
	end

	for ingredientName, ingredientAmount in recipe.recipe do
		local ingredientTemplate = self.ingredientsTemplate:Clone()
		ingredientTemplate.Name = ingredientName
		ingredientTemplate.ImageLabel.Image = "" --ingredient.image
		ingredientTemplate.TextLabel.Text = ingredientName .. " x " .. ingredientAmount
		ingredientTemplate.Parent = self.ingredientsContainer
		ingredientTemplate.Visible = true
	end
end
return RecipeUI
