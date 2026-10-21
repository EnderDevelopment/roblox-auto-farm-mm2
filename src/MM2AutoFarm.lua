-- MM2 Auto-Farm Script

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local autoFarmEnabled = false
local autoFarmSpeed = 1

local function collectCoins()
    while autoFarmEnabled do
        local function collectCoins()
    while autoFarmEnabled do
        for _, coin in ipairs(workspace:GetDescendants()) do
            if coin.Name == "Coin" and coin:IsA("BasePart") then
                humanoid:MoveTo(coin.Position)
                wait(1 / autoFarmSpeed)
            end
        end
        if not autoFarmEnabled then break end
    end
end
        wait(1 / autoFarmSpeed)
    end
end

local function toggleAutoFarm()
    autoFarmEnabled = not autoFarmEnabled
    if autoFarmEnabled then
        collectCoins()
    end
end

local function setAutoFarmSpeed(speed)
    autoFarmSpeed = math.clamp(speed, 1, 27)
end

-- UI Setup
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local toggleButton = Instance.new("TextButton")
local speedSlider = Instance.new("TextBox")

screenGui.Parent = player:WaitForChild("PlayerGui")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

-- Toggle Button
toggleButton.Parent = frame
toggleButton.Size = UDim2.new(0, 180, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Auto-Farm: OFF"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
toggleButton.MouseButton1Click:Connect(toggleAutoFarm)

-- Speed Slider
speedSlider.Parent = frame
speedSlider.Size = UDim2.new(0, 180, 0, 30)
speedSlider.Position = UDim2.new(0, 10, 0, 50)
speedSlider.Text = tostring(autoFarmSpeed)
speedSlider.TextColor3 = Color3.new(1, 1, 1)
speedSlider.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
speedSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        setAutoFarmSpeed(tonumber(speedSlider.Text))
        speedSlider.Text = tostring(autoFarmSpeed)
    end
end)

-- Update UI when auto-farm is toggled
local function updateUI()
    toggleButton.Text = "Auto-Farm: " .. (autoFarmEnabled and "ON" or "OFF")
end

-- Connect to character changes
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
end)

-- Initial UI update
updateUI()

-- Handle game round end
local function onRoundEnd()
    autoFarmEnabled = false
    updateUI()
end

-- Connect to round end event (you'll need to replace this with the actual event name)
-- game:GetService("GameManager").RoundEnded:Connect(onRoundEnd)

-- Handle maximum coins reached
local function onMaxCoinsReached()
    autoFarmEnabled = false
    updateUI()
end

-- Connect to max coins event (you'll need to replace this with the actual event name)
-- game:GetService("CoinManager").MaxCoinsReached:Connect(onMaxCoinsReached)