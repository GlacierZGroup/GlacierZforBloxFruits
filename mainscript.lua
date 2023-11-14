-- Function to create an iceberg-shaped GUI with specified properties
local function createIcebergGUI(position, size, color, text)
    local gui = Instance.new("ScreenGui")
    gui.Name = text
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = color
    frame.Parent = gui

    local label = Instance.new("TextLabel")
    label.Text = text
    label.Parent = frame

    return gui, frame
end

-- Function to make GUIs draggable
local function makeDraggable(gui, frame)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging then
            update(dragInput)
        end
    end)
end

-- Function to create a toggle button
local function createToggleButton(parent, position, size, color, text, onClick)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Position = position
    button.Size = UDim2.new(size, 0, size, 0)
    button.BackgroundColor3 = color
    button.Text = text

    button.MouseButton1Click:Connect(onClick)

    return button
end

-- Function to save the toggled buttons and script functions to a JSON file
local function saveConfig()
    local config = {}
    for _, button in pairs(workspace.GlacierZ:GetChildren()) do
        if button:IsA("TextButton") then
            local entry = {
                ButtonName = button.Text,
                Toggled = button.BackgroundColor3 == Color3.new(0.7, 0.8, 1)
                -- Add more properties as needed for your specific use case
            }
            table.insert(config, entry)
        end
    end

    local configString = game:GetService("HttpService"):JSONEncode(config)
    local filePath = game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetAttribute("AssetFolder").."\\config.json"

    local file = io.open(filePath, "w")
    if file then
        file:write(configString)
        file:close()
    end
end

-- Function to download assets into the workspace folder
local function downloadAssets()
    local assetFolder = game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetAttribute("AssetFolder")
    local glacierZAssets = {
        CustomModule = {
            FileName = "CustomModules.lua",
            Destination = workspace.GlacierZ,
        },
        ButtonAsset = {
            FileName = "ButtonAsset.lua",
            Destination = workspace,
        },
        -- Add more assets as needed
    }

    for _, asset in pairs(glacierZAssets) do
        local success, content = pcall(function()
            return game:GetService("HttpService"):GetAsync(assetFolder .. "/" .. asset.FileName)
        end)

        if success then
            local newScript = Instance.new("Script")
            newScript.Name = asset.FileName:gsub(".lua", "")
            newScript.Source = content
            newScript.Parent = asset.Destination

            -- Check if it's a button asset and create it in the workspace
            if asset.FileName == "ButtonAsset.lua" then
                local button = Instance.new("TextButton")
                button.Parent = asset.Destination
                button.Name = "DownloadedButton"
                button.Size = UDim2.new(0.2, 0, 0.1, 0)
                button.Position = UDim2.new(0.5, 0, 0.5, 0)
                button.BackgroundColor3 = Color3.new(0.7, 0.8, 1)
                button.Text = "Downloaded Button"
            end
        else
            warn("Failed to download asset:", asset.FileName)
        end
    end
end

-- Load and execute CustomModules.lua
local customModules = workspace.GlacierZ:FindFirstChild("CustomModules")
if customModules and customModules:IsA("Script") then
    pcall(function()
        loadstring(customModules.Source)()
    end)
end

-- Set up the four icebergs with specified properties
local gui1, frame1 = createIcebergGUI(UDim2.new(0.015, 0, 0.015, 0), UDim2.new(0.25, 0, 0.15, 0), Color3.new(0.7, 0.8, 1), "Iceberg 1")
local button11 = createToggleButton(frame1, UDim2.new(0.05, 0, 0.2, 0), 0.2, Color3.new(0.7, 0.8, 1), "Script 1", function() print("Script 1 executed") end)
-- Add more buttons as needed

local gui2, frame2 = createIcebergGUI(UDim2.new(0.3, 0, 0.015, 0), UDim2.new(0.25, 0, 0.15, 0), Color3.new(0.7, 0.8, 1), "Iceberg 2")
local button21 = createToggleButton(frame2, UDim2.new(0.05, 0, 0.2, 0), 0.2, Color3.new(0.7, 0.8, 1), "Script 2", function() print("Script 2 executed") end)
-- Add more buttons as needed

local gui3, frame3 = createIcebergGUI(UDim2.new(0.585, 0, 0.015, 0), UDim2.new(0.25, 0, 0.15, 0), Color3.new(0.7, 0.8, 1), "Iceberg 3")
local button31 = createToggleButton(frame3, UDim2.new(0.05, 0, 0.2, 0), 0.2, Color3.new(0.7, 0.8, 1), "Script 3", function() print("Script 3 executed") end)
-- Add more buttons as needed

local gui4, frame4 = createIcebergGUI(UDim2.new(0.87, 0, 0.015, 0), UDim2.new(0.25, 0, 0.15, 0), Color3.new(0.7, 0.8, 1), "Iceberg 4")
local button41 = createToggleButton(frame4, UDim2.new(0.05, 0, 0.2, 0), 0.2, Color3.new(0.7, 0.8, 1), "Script 4", function() print("Script 4 executed") end)
-- Add more buttons as needed

-- Make GUIs draggable
makeDraggable(gui1, frame1)
makeDraggable(gui2, frame2)
makeDraggable(gui3, frame3)
makeDraggable(gui4, frame4)

-- Download assets before loading GUI
downloadAssets()

-- Save the config when the game closes
game:BindToClose(saveConfig)
