
-- KHURRAM JUTT HUB V2.0
-- Server-side protection for your own game

local Players = game:GetService("Players")

local MAX_SPEED = 40
local MAX_HEALTH = 100

local function protectCharacter(character)
    local humanoid = character:WaitForChild("Humanoid")

    humanoid.MaxHealth = MAX_HEALTH
    humanoid.Health = MAX_HEALTH

    humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if humanoid.WalkSpeed > MAX_SPEED then
            humanoid.WalkSpeed = 16
        end
    end)

    humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
        humanoid.MaxHealth = MAX_HEALTH
    end)
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(protectCharacter)
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player.Character then
        task.spawn(protectCharacter, player.Character)
    end
    player.CharacterAdded:Connect(protectCharacter)
end

print("KHURRAM JUTT PROTECTION ACTIVE")

-- PLAYER SELECTOR WITH GREEN HIGHLIGHT

local playerButton = Instance.new("TextButton")
playerButton.Size = UDim2.new(1,-20,0,38)
playerButton.Position = UDim2.fromOffset(10,55)
playerButton.BackgroundColor3 = Color3.fromRGB(35,35,35)
playerButton.TextColor3 = Color3.new(1,1,1)
playerButton.Text = "SELECT PLAYER ▼"
playerButton.Parent = main

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1,-20,0,110)
list.Position = UDim2.fromOffset(10,98)
list.BackgroundColor3 = Color3.fromRGB(20,20,20)
list.Visible = false
list.ScrollBarThickness = 4
list.CanvasSize = UDim2.new(0,0,0,0)
list.Parent = main

local selectedPlayer = nil

local function refreshPlayers()
    list:ClearAllChildren()
    local layout = Instance.new("UIListLayout")
    layout.Parent = list

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            local item = Instance.new("TextButton")
            item.Size = UDim2.new(1,-5,0,30)
            item.BackgroundColor3 =
                p == selectedPlayer
                and Color3.fromRGB(0,130,65)
                or Color3.fromRGB(40,40,40)

            item.Text = p.Name
            item.TextColor3 = Color3.new(1,1,1)
            item.Parent = list

            item.MouseButton1Click:Connect(function()
                selectedPlayer = p
                playerButton.Text = "✓ " .. p.Name
                playerButton.TextColor3 = Color3.fromRGB(0,255,100)
                list.Visible = false
                refreshPlayers()
            end)
        end
    end

    list.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
end

playerButton.MouseButton1Click:Connect(function()
    list.Visible = not list.Visible
    refreshPlayers()
end)

Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(function(p)
    if selectedPlayer == p then
        selectedPlayer = nil
        playerButton.Text = "SELECT PLAYER ▼"
        playerButton.TextColor3 = Color3.new(1,1,1)
    end
    refreshPlayers()
end)

local selectedPlayer = nil

local function refreshPlayers()
    for _, child in ipairs(list:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local layout = list:FindFirstChildOfClass("UIListLayout")
    if not layout then
        layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0,3)
        layout.Parent = list
    end

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            local item = Instance.new("TextButton")
            item.Size = UDim2.new(1,-5,0,30)
            item.BackgroundColor3 =
                p == selectedPlayer
                and Color3.fromRGB(0,130,65)
                or Color3.fromRGB(40,40,40)

            item.Text = (p == selectedPlayer and "✓ " or "") .. p.Name
            item.TextColor3 = Color3.new(1,1,1)
            item.Font = Enum.Font.Gotham
            item.TextSize = 12
            item.Parent = list
            corner(item,5)

            item.Activated:Connect(function()
                selectedPlayer = p
                selector.Text = "✓ " .. p.Name
                selector.TextColor3 = Color3.fromRGB(0,255,100)
                list.Visible = false
                refreshPlayers()
            end)
        end
    end

    task.defer(function()
        list.CanvasSize = UDim2.new(
            0,0,0,layout.AbsoluteContentSize.Y + 5
        )
    end)
end

selector.Activated:Connect(function()
    list.Visible = not list.Visible
    refreshPlayers()
end)

Players.PlayerAdded:Connect(refreshPlayers)

Players.PlayerRemoving:Connect(function(p)
    if selectedPlayer == p then
        selectedPlayer = nil
        selector.Text = "SELECT PLAYER ▼"
        selector.TextColor3 = Color3.new(1,1,1)
    end
    refreshPlayers()
end)

-- Feature buttons (visual demo)
local features = {
    "Anti Fling",
    "Anti Bang",
    "Anti Kill",
    "Speed",
    "Super Jump",
    "Fly",
    "Height"
}

local y = 210

for _, name in ipairs(features) do
    local enabled = false

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,-20,0,30)
    button.Position = UDim2.fromOffset(10,y)
    button.BackgroundColor3 = Color3.fromRGB(35,35,35)
    button.TextColor3 = Color3.new(1,1,1)
    button.Text = name .. " : OFF"
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.Parent = main
    corner(button,6)

    button.Activated:Connect(function()
        enabled = not enabled
        button.Text = name .. (enabled and " : ON" or " : OFF")
        button.BackgroundColor3 = enabled
            and Color3.fromRGB(0,110,55)
            or Color3.fromRGB(35,35,35)
    end)

    y = y + 34
end

print("KHURRAM JUTT HUB V5.0 LOADED")

