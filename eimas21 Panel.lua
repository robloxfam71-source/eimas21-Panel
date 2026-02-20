--// Xke8F Panel - Clean GUI with Toggles, Pages, FPS Booster, Fly, WalkFling, Noclip, Invis, Safe Mode, Heal, Respawn

--== Services ==--
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer

--== GUI Creation (B1 Clean Flat Style) ==--
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NeonExecutorGui"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 460, 0, 520)
Frame.Position = UDim2.new(0.5, -230, 0.5, -260)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Parent = Frame
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Xke8F PANEL"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button (C1)
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18

CloseButton.MouseEnter:Connect(function()
    CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
end)

CloseButton.MouseLeave:Connect(function()
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
end)

-- Section Header
local SectionLabel = Instance.new("TextLabel")
SectionLabel.Parent = Frame
SectionLabel.Size = UDim2.new(1, -20, 0, 30)
SectionLabel.Position = UDim2.new(0, 10, 0, 50)
SectionLabel.BackgroundTransparency = 1
SectionLabel.Text = "FEATURES"
SectionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SectionLabel.Font = Enum.Font.GothamBold
SectionLabel.TextSize = 16
SectionLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Page Containers
local Page1 = Instance.new("ScrollingFrame")
Page1.Parent = Frame
Page1.Size = UDim2.new(1, -20, 1, -140)
Page1.Position = UDim2.new(0, 10, 0, 90)
Page1.BackgroundTransparency = 1
Page1.ScrollBarThickness = 6
Page1.CanvasSize = UDim2.new(0, 0, 0, 0)

local Page2 = Instance.new("ScrollingFrame")
Page2.Parent = Frame
Page2.Size = UDim2.new(1, -20, 1, -140)
Page2.Position = UDim2.new(0, 10, 0, 90)
Page2.BackgroundTransparency = 1
Page2.ScrollBarThickness = 6
Page2.CanvasSize = UDim2.new(0, 0, 0, 0)
Page2.Visible = false

-- Auto Layout
local function MakeList(parent)
    local layout = Instance.new("UIListLayout")
    layout.Parent = parent
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local pad = Instance.new("UIPadding")
    pad.Parent = parent
    pad.PaddingTop = UDim.new(0, 4)

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        parent.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
end

MakeList(Page1)
MakeList(Page2)

-- Fade hover helper (A1)
local function AddFadeHover(guiObject, baseColor, hoverColor, time)
    guiObject.MouseEnter:Connect(function()
        TweenService:Create(guiObject, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = hoverColor
        }):Play()
    end)
    guiObject.MouseLeave:Connect(function()
        TweenService:Create(guiObject, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = baseColor
        }):Play()
    end)
end

-- Button Maker (normal buttons)
local function MakeButton(text, parent)
    local b = Instance.new("TextButton")
    b.Parent = parent
    b.Size = UDim2.new(1, -10, 0, 36)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.Text = text
    b.AutoButtonColor = false
    b.BorderSizePixel = 0

    AddFadeHover(b, Color3.fromRGB(40, 40, 40), Color3.fromRGB(55, 55, 55), 0.12)

    return b
end

-- Toggle Maker (T2 sliding switch)
local function MakeToggle(text, parent, callback)
    local container = Instance.new("Frame")
    container.Parent = parent
    container.Size = UDim2.new(1, -10, 0, 36)
    container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    container.BorderSizePixel = 0

    AddFadeHover(container, Color3.fromRGB(40, 40, 40), Color3.fromRGB(55, 55, 55), 0.12)

    local label = Instance.new("TextLabel")
    label.Parent = container
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local switch = Instance.new("Frame")
    switch.Parent = container
    switch.Size = UDim2.new(0, 40, 0, 18)
    switch.Position = UDim2.new(1, -50, 0.5, -9)
    switch.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    switch.BorderSizePixel = 0

    local knob = Instance.new("Frame")
    knob.Parent = switch
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 1, 0, 1)
    knob.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    knob.BorderSizePixel = 0

    local state = false

    local function SetState(on)
        state = on
        local targetPos = on and UDim2.new(1, -17, 0, 1) or UDim2.new(0, 1, 0, 1)
        local targetColor = on and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(80, 80, 80)

        TweenService:Create(switch, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = targetColor
        }):Play()

        TweenService:Create(knob, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = targetPos
        }):Play()

        if callback then
            callback(state)
        end
    end

    local clickArea = Instance.new("TextButton")
    clickArea.Parent = container
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.Position = UDim2.new(0, 0, 0, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""

    clickArea.MouseButton1Click:Connect(function()
        SetState(not state)
    end)

    return {
        SetState = SetState,
        GetState = function() return state end,
        Container = container
    }
end

-- Page 1: Buttons + Toggles
local playBtn      = MakeButton("Play Sound", Page1)
local stopBtn      = MakeButton("Stop Sound", Page1)

local flyToggle
local walkflingToggle
local noclipToggle
local invisToggle
local safeModeToggle

local healBtn
local respawnBtn
local nextPageBtn

-- Page 2 Buttons
local fpsBtn
local animBtn
local backBtn

-- Bottom Button
local BottomButton = Instance.new("TextButton")
BottomButton.Parent = Frame
BottomButton.Size = UDim2.new(1, -20, 0, 40)
BottomButton.Position = UDim2.new(0, 10, 1, -50)
BottomButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
BottomButton.Text = "EXECUTE PANEL"
BottomButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BottomButton.Font = Enum.Font.GothamBold
BottomButton.TextSize = 16
BottomButton.BorderSizePixel = 0

AddFadeHover(BottomButton, Color3.fromRGB(60, 60, 60), Color3.fromRGB(80, 80, 80), 0.12)

--== Draggable Frame ==--
local dragging = false
local dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

--== Sound Setup ==--
local sound = Instance.new("Sound")
sound.Parent = workspace
sound.SoundId = "rbxassetid://83142759678663"
sound.Volume = 5

playBtn.MouseButton1Click:Connect(function()
    sound:Play()
end)

stopBtn.MouseButton1Click:Connect(function()
    sound:Stop()
end)

--== Fly (WASD) ==--
local flying = false
local flyVel, flyGyro
local flySpeed = 60

--== WalkFling ==--
local walkfling = false
local flingPart
local followConnection
local touchConnection

--== Noclip ==--
local noclip = false

--== Invisible ==--
local invisibleOn = false

--== Safe Mode ==--
local safeMode = false
local safeConnection

-- Fly toggle
flyToggle = MakeToggle("Fly", Page1, function(on)
    flying = on
    local char = lp.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if flying then
        flyVel = Instance.new("BodyVelocity")
        flyVel.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        flyVel.Parent = hrp

        flyGyro = Instance.new("BodyGyro")
        flyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        flyGyro.Parent = hrp

        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not flying or not hrp or not hrp.Parent then
                conn:Disconnect()
                return
            end

            local cam = workspace.CurrentCamera
            flyGyro.CFrame = cam.CFrame

            local move = Vector3.new()
            if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end

            flyVel.Velocity = move * flySpeed
        end)
    else
        if flyVel then flyVel:Destroy() flyVel = nil end
        if flyGyro then flyGyro:Destroy() flyGyro = nil end
    end
end)

-- WalkFling toggle (fixed so it doesn't fling you)
walkflingToggle = MakeToggle("WalkFling", Page1, function(on)
    walkfling = on

    local char = lp.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if walkfling then
        -- Create invisible detection part
        flingPart = Instance.new("Part")
        flingPart.Size = Vector3.new(6, 6, 6)
        flingPart.Transparency = 1
        flingPart.CanCollide = false
        flingPart.Anchored = false
        flingPart.Massless = true
        flingPart.Parent = workspace
        flingPart.Name = "VelocityFlingDetector"

        -- Follow player
        followConnection = RunService.Heartbeat:Connect(function()
            if flingPart and hrp and hrp.Parent then
                flingPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -3)
            end
        end)

        -- Apply velocity to others
        touchConnection = flingPart.Touched:Connect(function(hit)
            if hit:IsDescendantOf(char) then return end -- ignore yourself

            local otherChar = hit.Parent
            local otherHRP = otherChar and otherChar:FindFirstChild("HumanoidRootPart")
            if otherHRP then
                    otherHRP.Velocity = Vector3.new(0, 0, 0)
                task.wait()
                otherHRP.Velocity = hrp.CFrame.LookVector * 500 + Vector3.new(0, 300, 0)
            end
        end)

    else
        if followConnection then followConnection:Disconnect() followConnection = nil end
        if touchConnection then touchConnection:Disconnect() touchConnection = nil end
        if flingPart then flingPart:Destroy() flingPart = nil end
    end
end)


-- Noclip toggle
noclipToggle = MakeToggle("Noclip", Page1, function(on)
    noclip = on
end)

-- Invisible toggle
invisToggle = MakeToggle("Invisible", Page1, function(on)
    invisibleOn = on
    local char = lp.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.Transparency = invisibleOn and 1 or 0
        end
    end
end)

-- Safe Mode toggle
safeModeToggle = MakeToggle("Safe Mode", Page1, function(on)
    safeMode = on

    if safeMode then
        safeConnection = RunService.Heartbeat:Connect(function()
            local char = lp.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp then return end

            if hum.Health < hum.MaxHealth then
                hum.Health = math.min(hum.MaxHealth, hum.Health + 2)
            end

            if hrp.Velocity.Y < -80 then
                hrp.Velocity = Vector3.new(hrp.Velocity.X, -20, hrp.Velocity.Z)
            end

            hum.PlatformStand = false
        end)
    else
        if safeConnection then safeConnection:Disconnect() safeConnection = nil end
    end
end)

-- Self-Heal, Respawn, Next Page
healBtn = MakeButton("Self-Heal", Page1)
respawnBtn = MakeButton("Respawn", Page1)
nextPageBtn = MakeButton("Next Page →", Page1)

-- Page 2: FPS, Animation, Back
fpsBtn = MakeButton("FPS Booster", Page2)
animBtn = MakeButton("Play Animation", Page2)
backBtn = MakeButton("← Back", Page2)

-- Noclip loop
RunService.Stepped:Connect(function()
    if noclip and lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- Self-Heal
healBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Health = hum.MaxHealth
    end
end)

-- Respawn
respawnBtn.MouseButton1Click:Connect(function()
    local plr = game.Players.LocalPlayer

    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.Health = 0
    end

    plr.CharacterAdded:Wait()
    plr:LoadCharacter()
end)

-- FPS BOOSTER
fpsBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Texture") or v:IsA("Decal") then
            v:Destroy()
        end
    end

    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end

    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then
            v.Enabled = false
        end
    end

    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    Lighting.GlobalShadows = false
    Workspace.Terrain.Decoration = false
end)

-- Animation
animBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://136230267630603" -- Dance 2

    local track = hum:LoadAnimation(anim)
    track:Play()
end)

-- Page Switching
nextPageBtn.MouseButton1Click:Connect(function()
    Page1.Visible = false
    Page2.Visible = true
end)

backBtn.MouseButton1Click:Connect(function()
    Page2.Visible = false
    Page1.Visible = true
end)

-- Keybind K to hide/show GUI
local hidden = false

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.K then
        hidden = not hidden
        Frame.Visible = not hidden
    end
end)
