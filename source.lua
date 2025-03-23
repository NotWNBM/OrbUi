local Library = {}

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true  -- Enables input detection
    MainFrame.Draggable = true  -- Allows dragging

    local Title = Instance.new("TextLabel")
    Title.Text = title
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Parent = MainFrame
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Text = "X"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Parent = MainFrame
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Text = "_"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.Parent = MainFrame
    
    local isMinimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        for _, v in pairs(MainFrame:GetChildren()) do
            if v:IsA("Frame") and v.Name ~= "TabContainer" then
                v.Visible = not isMinimized
            end
        end
        MinimizeButton.Text = isMinimized and "□" or "_"
    end)
    
    return {MainFrame = MainFrame, ScreenGui = ScreenGui}
end

function Library:CreateTab(window, tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Text = tabName
    TabButton.Size = UDim2.new(0, 100, 0, 30)
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Parent = window.MainFrame

    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1, 0, 1, -30)
    TabFrame.Position = UDim2.new(0, 0, 0, 30)
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabFrame.Visible = false
    TabFrame.Parent = window.MainFrame

    TabButton.MouseButton1Click:Connect(function()
        for _, v in pairs(window.MainFrame:GetChildren()) do
            if v:IsA("Frame") and v ~= TabFrame then
                v.Visible = false
            end
        end
        TabFrame.Visible = true
    end)

    return TabFrame
end

function Library:CreateButton(tab, text, callback)
    local Button = Instance.new("TextButton")
    Button.Text = text
    Button.Size = UDim2.new(1, -10, 0, 40)
    Button.Position = UDim2.new(0, 5, 0, 5)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Parent = tab

    Button.MouseButton1Click:Connect(function()
        callback()
    end)
end

return Library
