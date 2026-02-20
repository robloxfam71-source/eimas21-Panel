--// Neon Executor GUI with Pages, FPS Booster, Fly, WalkFling, Noclip, Invis, Safe Mode, Heal, Respawn

--== Services ==--
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local lp = Players.LocalPlayer

--== GUI Creation ==--
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NeonExecutorGui"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 260, 0, 420)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Frame.BorderSizePixel = 0

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(0, 255, 200)
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Stroke.Parent = Frame

local TitleBar = Instance.new("Frame")
TitleBar.Parent = Frame
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.Size = UDim2.new(1, -10, 1, 0)
TitleLabel.Position = UDim2.new(0, 5, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Xke8F Panel"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

--== Page Containers ==--
local Page1 = Instance.new("Frame")
Page1.Parent = Frame
Page1.Size = UDim2.new(1, -20, 1, -50)
Page1.Position = UDim2.new(0, 10, 0, 40)
Page1.BackgroundTransparency = 1

local Page2 = Instance.new("Frame")
Page2.Parent = Frame
Page2.Size = UDim2.new(1, -20, 1, -50)
Page2.Position = UDim2.new(0, 10, 0, 40)
Page2.BackgroundTransparency = 1
Page2.Visible = false

local function MakeList(parent)
    local layout = Instance.new("UIListLayout")
    layout.Parent = parent
    layout.Padding = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local pad = Instance.new("UIPadding")
    pad.Parent = parent
    pad.PaddingTop = UDim.new(0, 4)
end

MakeList(Page1)
MakeList(Page2)

local function MakeButton(text, parent)
    local b = Instance.new("TextButton")
    b.Parent = parent
    b.Size = UDim2.new(1, 0, 0, 32)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    b.TextColor3 = Color3.fromRGB(220, 255, 255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.Text = text
    b.AutoButtonColor = false

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = b

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(0, 200, 255)
    stroke.Parent = b

    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
    end)

    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    end)

    return b
end

--== Page 1 Buttons ==--
local playBtn      = MakeButton("Play Sound", Page1)
local stopBtn      = MakeButton("Stop Sound", Page1)
local flyBtn       = MakeButton("Fly", Page1)
local walkflingBtn = MakeButton("WalkFling", Page1)
local noclipBtn    = MakeButton("Noclip", Page1)
local unnoclipBtn  = MakeButton("Un-Noclip", Page1)
local invisBtn     = MakeButton("Invisible", Page1)
local uninvisBtn   = MakeButton("Un-Invisible", Page1)
local safeModeBtn  = MakeButton("Safe Mode (Toggle)", Page1)
local healBtn      = MakeButton("Self-Heal", Page1)
local respawnBtn   = MakeButton("Respawn", Page1)
local nextPageBtn  = MakeButton("Next Page →", Page1)

--== Page 2 Buttons ==--
local fpsBtn       = MakeButton("FPS Booster", Page2)
local backBtn      = MakeButton("← Back", Page2)

--== ANIMATION BUTTON ==--
local animBtn      = MakeButton("Play Animation", Page2)

--== Page Switching ==--
nextPageBtn.MouseButton1Click:Connect(function()
    Page1.Visible = false
    Page2.Visible = true
end)

backBtn.MouseButton1Click:Connect(function()
    Page2.Visible = false
    Page1.Visible = true
end)

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

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
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

--== WalkFling ==--
local walkfling = false
local flingPart
local followConnection
local touchConnection

walkflingBtn.MouseButton1Click:Connect(function()
    walkfling = not walkfling

    local char = lp.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if walkfling then
        flingPart = Instance.new("Part")
        flingPart.Size = Vector3.new(4, 4, 4)
        flingPart.Transparency = 1
        flingPart.CanCollide = false
        flingPart.Massless = true
        flingPart.Parent = workspace
        flingPart.Name = "FlingCore"

        local bav = Instance.new("BodyAngularVelocity")
        bav.AngularVelocity = Vector3.new(0, 999999, 0)
        bav.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        bav.Parent = flingPart

        followConnection = RunService.Heartbeat:Connect(function()
            if flingPart and hrp and hrp.Parent then
                flingPart.CFrame = hrp.CFrame
            end
        end)

        touchConnection = flingPart.Touched:Connect(function(hit)
            local otherChar = hit.Parent
            if not otherChar or otherChar == char then return end
            local otherHRP = otherChar:FindFirstChild("HumanoidRootPart")
            if otherHRP then
                otherHRP.Velocity = Vector3.new(0, 0, 0)
                task.wait()
                otherHRP.Velocity = hrp.CFrame.LookVector * 300 + Vector3.new(0, 200, 0)
            end
        end)
    else
        if followConnection then followConnection:Disconnect() followConnection = nil end
        if touchConnection then touchConnection:Disconnect() touchConnection = nil end
        if flingPart then flingPart:Destroy() flingPart = nil end
    end
end)

--== Noclip ==--
local noclip = false

noclipBtn.MouseButton1Click:Connect(function()
    noclip = true
end)

unnoclipBtn.MouseButton1Click:Connect(function()
    noclip = false
end)

RunService.Stepped:Connect(function()
    if noclip and lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

--== Invisible ==--
invisBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.Transparency = 1
        end
    end
end)

uninvisBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 0
        end
    end
end)

--== Safe Mode ==--
local safeMode = false
local safeConnection

safeModeBtn.MouseButton1Click:Connect(function()
    safeMode = not safeMode

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

        if not Frame:FindFirstChild("SafeGlow") then
            local glow = Instance.new("UIStroke")
            glow.Name = "SafeGlow"
            glow.Thickness = 3
            glow.Color = Color3.fromRGB(0, 255, 120)
            glow.Parent = Frame
        end
    else
        if safeConnection then safeConnection:Disconnect() safeConnection = nil end
        local glow = Frame:FindFirstChild("SafeGlow")
        if glow then glow:Destroy() end
    end
end)

--== Self-Heal ==--
healBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Health = hum.MaxHealth
    end
end)

--== Respawn ==--
respawnBtn.MouseButton1Click:Connect(function()
    local plr = game.Players.LocalPlayer

    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.Health = 0
    end

    plr.CharacterAdded:Wait()
    plr:LoadCharacter()
end)

--== FPS BOOSTER ==--
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

animBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://507776043" -- Dance 2 (you can change this)

    local track = hum:LoadAnimation(anim)
    track:Play()
end)


--== Keybind K to hide/show GUI ==--
local hidden = false

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.K then
        hidden = not hidden
        Frame.Visible = not hidden
    end
end)

