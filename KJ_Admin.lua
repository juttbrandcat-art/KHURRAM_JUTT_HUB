
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

