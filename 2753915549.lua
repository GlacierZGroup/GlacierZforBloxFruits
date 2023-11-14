return {
    Name = "Test Button",
    GuiLibrary = "gui1", -- Replace with the actual GUI library reference
    Enabled = false,

    Init = function()
        -- Initialization logic (executed when the game starts)
        if not Enabled then
            return function()
                -- Custom script logic when the button is toggled off by default
                print("Custom script for Test Button (toggled off) executed!")
            end
        end
    end,

    ToggleScript = function()
        -- Custom script logic when the button is toggled on/off
        print("Custom script for Test Button toggled!")
    end
}
