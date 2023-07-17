-- ESP Settings
local ESPEnabled = false
local BoxColor = Color3.new(1, 0, 0)
local BoxTransparency = 0.5
local BoxThickness = 1

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ESP_GUI"
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "ESP_Frame"
frame.Position = UDim2.new(0, 10, 0, 10)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Parent = gui

local label = Instance.new("TextLabel")
label.Name = "ESP_Label"
label.Position = UDim2.new(0, 10, 0, 10)
label.Size = UDim2.new(0, 180, 0, 20)
label.Text = "ESP: OFF"
label.TextColor3 = Color3.new(1, 1, 1)
label.TextSize = 16
label.Parent = frame

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ESP_ToggleButton"
toggleButton.Position = UDim2.new(0, 10, 0, 40)
toggleButton.Size = UDim2.new(0, 180, 0, 30)
toggleButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
toggleButton.Text = "Toggle ESP"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.TextSize = 16
toggleButton.Parent = frame

-- Create ESP Box function
local function createESPBox(part)
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESPBox"
    box.Size = part.Size + Vector3.new(0.1, 0.1, 0.1)
    box.Color3 = BoxColor
    box.Transparency = BoxTransparency
    box.Adornee = part
    box.Parent = part
    box.ZIndex = 10
    box.AlwaysOnTop = true
    box.Thickness = BoxThickness
end

-- Toggle ESP function
local function toggleESP()
    ESPEnabled = not ESPEnabled
    label.Text = "ESP: " .. (ESPEnabled and "ON" or "OFF")
    
    if not ESPEnabled then
        -- Remove all ESP boxes
        for _, box in ipairs(game.Workspace:GetDescendants()) do
            if box.Name == "ESPBox" then
                box:Destroy()
            end
        end
    end
end

-- Connect toggle button click event
toggleButton.MouseButton1Click:Connect(toggleESP)

-- ESP Main Loop
game:GetService("RunService").RenderStepped:Connect(function()
    if ESPEnabled then
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game:GetService("Players").LocalPlayer then
                local character = player.Character
                if character then
                    for _, part in ipairs(character:GetDescendants()) do
                        if part:IsA("BasePart") and part ~= character.PrimaryPart then
                            if not part:FindFirstChild("ESPBox") then
                                createESPBox(part)
                            end
                        end
                    end
                end
            end
        end
    end
end)
