local GlacierZFolder = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("GlacierZ") or Instance.new("Folder")
GlacierZFolder.Name = "GlacierZ"
GlacierZFolder.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local CustomModulesFolder = GlacierZFolder:FindFirstChild("CustomModules") or Instance.new("Folder")
CustomModulesFolder.Name = "CustomModules"
CustomModulesFolder.Parent = GlacierZFolder

-- Function to save the toggled buttons and script functions to a JSON file
local function saveConfig()
    local config = {}
    for _, button in pairs(GlacierZFolder:GetChildren()) do
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
            FileName = "2753915549.lua",
            Destination = CustomModulesFolder,
        },
        -- Add more assets as needed
    }

    for _, asset in pairs(glacierZAssets) do
        local success, content = pcall(function()
            return game:GetService("HttpService"):GetAsync(assetFolder .. "/" .. asset.FileName)
        end)

        if success then
            local moduleScript = Instance.new("ModuleScript")
            moduleScript.Name = asset.FileName:gsub(".lua", "")
            moduleScript.Source = content
            moduleScript.Parent = asset.Destination
        else
            warn("Failed to download asset:", asset.FileName)
        end
    end
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

