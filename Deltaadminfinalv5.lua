--[[
  ██████╗ ███████╗██╗  ████████╗ █████╗ 
  ██╔══██╗██╔════╝██║  ╚══██╔══╝██╔══██╗
  ██║  ██║█████╗  ██║     ██║   ███████║
  ██║  ██║██╔══╝  ██║     ██║   ██╔══██║
  ██████╔╝███████╗███████╗██║   ██║  ██║
  ╚═════╝ ╚══════╝╚══════╝╚═╝   ╚═╝  ╚═╝
  DELTA ADMIN V5 - EDISI RUSUH TOTAL
  oleh maliki092007 | Update MAP DESTROYER
]]

-- LAYANAN
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- STATUS
local States = {
    speedEnabled = false,
    speedValue = 16,
    jumpEnabled = false,
    jumpValue = 50,
    noclipEnabled = false,
    infJumpEnabled = false,
    checkpoint = nil,
    chatSpamEnabled = false,
    chatSpamText = "💀 DIHACK OLEH DELTA ADMIN 💀",
    flingTarget = nil,
    orbitTarget = nil,
    orbitEnabled = false,
    attachTarget = nil,
    attachEnabled = false,
    panelOpen = false,
    currentTab = "CP"
}

-- HAPUS GUI LAMA
if game.CoreGui:FindFirstChild("DeltaAdminV5") then
    game.CoreGui:FindFirstChild("DeltaAdminV5"):Destroy()
end

-- LAYAR GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaAdminV5"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- ========== TOMBOL BUKA ==========
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 8, 0.5, -22)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.Text = "⚡"
ToggleBtn.TextSize = 22
ToggleBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = ScreenGui
ToggleBtn.ZIndex = 999

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 215, 0)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- BISA DIGESER
local dragging, dragStart, startPos
ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = ToggleBtn.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ========== PANEL UTAMA ==========
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 440)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -220)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.ZIndex = 100

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 215, 0)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.BorderSizePixel = 0
Header.Parent = MainFrame
Header.ZIndex = 101

Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Delta Admin V5"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header
Title.ZIndex = 102

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -38, 0, 3)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header
CloseBtn.ZIndex = 102
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

-- ========== BAR TAB ==========
local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(1, -10, 0, 35)
TabBar.Position = UDim2.new(0, 5, 0, 43)
TabBar.BackgroundTransparency = 1
TabBar.ScrollBarThickness = 0
TabBar.CanvasSize = UDim2.new(0, 750, 0, 0)
TabBar.ScrollingDirection = Enum.ScrollingDirection.X
TabBar.Parent = MainFrame
TabBar.ZIndex = 101

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 5)
TabLayout.Parent = TabBar

-- ========== AREA KONTEN ==========
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(1, -16, 1, -88)
ContentArea.Position = UDim2.new(0, 8, 0, 82)
ContentArea.BackgroundTransparency = 1
ContentArea.ScrollBarThickness = 3
ContentArea.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
ContentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentArea.Parent = MainFrame
ContentArea.ZIndex = 101

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 6)
ContentLayout.Parent = ContentArea

ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentArea.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 10)
end)

-- ========== FUNGSI PEMBUAT UI ==========

local Tabs = {}
local TabContents = {}

local function buatTab(nama, ikon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = ikon .. " " .. nama
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.Parent = TabBar
    btn.ZIndex = 102
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 0, 0)
    content.AutomaticSize = Enum.AutomaticSize.Y
    content.BackgroundTransparency = 1
    content.Visible = false
    content.Parent = ContentArea
    content.ZIndex = 101

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.Parent = content

    Tabs[nama] = btn
    TabContents[nama] = content

    btn.MouseButton1Click:Connect(function()
        for n, b in pairs(Tabs) do
            b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            b.TextColor3 = Color3.fromRGB(180, 180, 180)
            TabContents[n].Visible = false
        end
        btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        content.Visible = true
        States.currentTab = nama
    end)

    return content
end

local function buatTombol(parent, teks, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = teks
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = parent
    btn.ZIndex = 102
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(60, 60, 60)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function buatToggle(parent, teks, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 38)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Parent = parent
    frame.ZIndex = 102
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", frame).Color = Color3.fromRGB(60, 60, 60)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = teks
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    label.ZIndex = 103

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 50, 0, 24)
    toggle.Position = UDim2.new(1, -60, 0.5, -12)
    toggle.BackgroundColor3 = default and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(80, 80, 80)
    toggle.Text = default and "AKTIF" or "MATI"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 10
    toggle.Font = Enum.Font.GothamBold
    toggle.Parent = frame
    toggle.ZIndex = 103
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6)

    local enabled = default
    toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        toggle.Text = enabled and "AKTIF" or "MATI"
        toggle.BackgroundColor3 = enabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(80, 80, 80)
        callback(enabled)
    end)
    return frame
end

local function buatSlider(parent, teks, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 55)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Parent = parent
    frame.ZIndex = 102
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", frame).Color = Color3.fromRGB(60, 60, 60)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 3)
    label.BackgroundTransparency = 1
    label.Text = teks .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 215, 0)
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    label.ZIndex = 103

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -20, 0, 14)
    sliderBg.Position = UDim2.new(0, 10, 0, 28)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderBg.Parent = frame
    sliderBg.ZIndex = 103
    Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(0, 7)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    fill.Parent = sliderBg
    fill.ZIndex = 104
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 7)

    local sliderBtn = Instance.new("TextButton")
    sliderBtn.Size = UDim2.new(1, 0, 1, 0)
    sliderBtn.BackgroundTransparency = 1
    sliderBtn.Text = ""
    sliderBtn.Parent = sliderBg
    sliderBtn.ZIndex = 105

    local function update(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        label.Text = teks .. ": " .. value
        callback(value)
    end

    local sliding = false
    sliderBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = true
            update(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            update(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = false
        end
    end)
    return frame
end

local function buatPilihPemain(parent, teks, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 0)
    frame.AutomaticSize = Enum.AutomaticSize.Y
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Parent = parent
    frame.ZIndex = 102
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", frame).Color = Color3.fromRGB(60, 60, 60)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = teks
    label.TextColor3 = Color3.fromRGB(255, 215, 0)
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.Parent = frame
    label.ZIndex = 103

    local listFrame = Instance.new("Frame")
    listFrame.Size = UDim2.new(1, -8, 0, 0)
    listFrame.Position = UDim2.new(0, 4, 0, 30)
    listFrame.AutomaticSize = Enum.AutomaticSize.Y
    listFrame.BackgroundTransparency = 1
    listFrame.Parent = frame
    listFrame.ZIndex = 103

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 3)
    listLayout.Parent = listFrame

    local function refresh()
        for _, c in pairs(listFrame:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP then
                local pbtn = Instance.new("TextButton")
                pbtn.Size = UDim2.new(1, 0, 0, 28)
                pbtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                pbtn.Text = "👤 " .. p.Name
                pbtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                pbtn.TextSize = 11
                pbtn.Font = Enum.Font.Gotham
                pbtn.Parent = listFrame
                pbtn.ZIndex = 104
                Instance.new("UICorner", pbtn).CornerRadius = UDim.new(0, 6)
                pbtn.MouseButton1Click:Connect(function()
                    callback(p)
                end)
            end
        end
    end

    refresh()
    Players.PlayerAdded:Connect(refresh)
    Players.PlayerRemoving:Connect(function() task.wait(0.1) refresh() end)
    return frame
end

-- ========== BUAT SEMUA TAB ==========

local cpTab = buatTab("CP", "📍")
local pemainTab = buatTab("Pemain", "👥")
local gerakTab = buatTab("Gerak", "🏃")
local rusuhTab = buatTab("Rusuh", "🤡")
local hancurTab = buatTab("Hancur", "🌍")
local karakterTab = buatTab("Karakter", "🎭")
local alatTab = buatTab("Alat", "🛠️")

-- TAB AKTIF DEFAULT
Tabs["CP"].BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Tabs["CP"].TextColor3 = Color3.fromRGB(0, 0, 0)
TabContents["CP"].Visible = true

-- ========== BUKA/TUTUP PANEL ==========
ToggleBtn.MouseButton1Click:Connect(function()
    States.panelOpen = not States.panelOpen
    MainFrame.Visible = States.panelOpen
end)

CloseBtn.MouseButton1Click:Connect(function()
    States.panelOpen = false
    MainFrame.Visible = false
end)

-- ==========================================
-- TAB 1: 📍 CP (Titik Simpan)
-- ==========================================
buatTombol(cpTab, "💾 Simpan Titik", function()
    local char = LP.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        States.checkpoint = char.HumanoidRootPart.CFrame
        StarterGui:SetCore("SendNotification", {Title="✅ Tersimpan", Text="Posisi berhasil disimpan!", Duration=2})
    end
end)

buatTombol(cpTab, "📍 Kembali ke Titik", function()
    if States.checkpoint then
        local char = LP.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = States.checkpoint
            StarterGui:SetCore("SendNotification", {Title="📍 Teleport", Text="Kembali ke titik tersimpan!", Duration=2})
        end
    else
        StarterGui:SetCore("SendNotification", {Title="❌ Gagal", Text="Belum ada titik tersimpan!", Duration=2})
    end
end)

-- ==========================================
-- TAB 2: 👥 Pemain
-- ==========================================
buatPilihPemain(pemainTab, "📍 Teleport ke Pemain (Ketuk nama)", function(player)
    local char = LP.Character
    local targetChar = player.Character
    if char and targetChar and char:FindFirstChild("HumanoidRootPart") and targetChar:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        StarterGui:SetCore("SendNotification", {Title="📍 Teleport", Text="Teleport ke "..player.Name, Duration=2})
    end
end)

buatPilihPemain(pemainTab, "🧲 Tarik Pemain (Ketuk nama)", function(player)
    local char = LP.Character
    local targetChar = player.Character
    if char and targetChar and char:FindFirstChild("HumanoidRootPart") and targetChar:FindFirstChild("HumanoidRootPart") then
        targetChar.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        StarterGui:SetCore("SendNotification", {Title="🧲 Tarik", Text=player.Name.." ditarik ke sini!", Duration=2})
    end
end)

-- ==========================================
-- TAB 3: 🏃 Gerak
-- ==========================================
buatSlider(gerakTab, "🏃 Kecepatan", 16, 500, 16, function(val)
    States.speedValue = val
end)

buatToggle(gerakTab, "🏃 Hack Kecepatan", false, function(on)
    States.speedEnabled = on
end)

buatSlider(gerakTab, "🦘 Kekuatan Lompat", 50, 500, 50, function(val)
    States.jumpValue = val
end)

buatToggle(gerakTab, "🦘 Hack Lompat", false, function(on)
    States.jumpEnabled = on
end)

buatToggle(gerakTab, "👻 Tembus Dinding", false, function(on)
    States.noclipEnabled = on
end)

buatToggle(gerakTab, "🔄 Lompat Tanpa Batas", false, function(on)
    States.infJumpEnabled = on
end)

-- ==========================================
-- TAB 4: 🤡 Rusuh (SEMUA NGEFEK KE SEMUA!)
-- ==========================================

local function ambilHRP(player)
    local c = player and player.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

-- FUNGSI LEMPAR
local function lemparPemain(target)
    local hrp = ambilHRP(LP)
    local tHrp = ambilHRP(target)
    if not hrp or not tHrp then return end

    local oldPos = hrp.CFrame
    local bv = Instance.new("BodyAngularVelocity")
    bv.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bv.AngularVelocity = Vector3.new(0, 9999, 0)
    bv.Parent = hrp

    for i = 1, 30 do
        hrp.CFrame = tHrp.CFrame
        RunService.Heartbeat:Wait()
    end

    bv:Destroy()
    hrp.CFrame = oldPos
end

buatPilihPemain(rusuhTab, "🧨 Lempar Pemain (Ketuk nama)", function(player)
    StarterGui:SetCore("SendNotification", {Title="🧨 Lempar", Text="Melempar "..player.Name.."...", Duration=2})
    task.spawn(function() lemparPemain(player) end)
end)

buatTombol(rusuhTab, "🌪️ Lempar Semua", function()
    StarterGui:SetCore("SendNotification", {Title="🌪️ Lempar Semua", Text="Semua orang dilempar!", Duration=2})
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            task.spawn(function() lemparPemain(p) end)
            task.wait(0.5)
        end
    end
end)

buatTombol(rusuhTab, "🚀 Lempar Super Semua", function()
    StarterGui:SetCore("SendNotification", {Title="🚀 SUPER LEMPAR", Text="KEKUATAN MAKSIMAL!", Duration=2})
    for _ = 1, 3 do
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP then
                task.spawn(function() lemparPemain(p) end)
            end
        end
        task.wait(0.3)
    end
end)

buatTombol(rusuhTab, "🧲 Tarik Semua ke Sini", function()
    local hrp = ambilHRP(LP)
    if not hrp then return end
    StarterGui:SetCore("SendNotification", {Title="🧲 Tarik Semua", Text="Semua ditarik ke sini!", Duration=2})
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            local tHrp = ambilHRP(p)
            if tHrp then
                tHrp.CFrame = hrp.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
            end
        end
    end
end)

buatTombol(rusuhTab, "⬆️ Terbangkan Semua ke Atas", function()
    StarterGui:SetCore("SendNotification", {Title="⬆️ Terbang", Text="Semua terbang ke atas!", Duration=2})
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            local tHrp = ambilHRP(p)
            if tHrp then
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, 500, 0)
                bv.MaxForce = Vector3.new(0, math.huge, 0)
                bv.Parent = tHrp
                game.Debris:AddItem(bv, 1)
            end
        end
    end
end)

buatTombol(rusuhTab, "💥 Gelombang Kejut", function()
    local hrp = ambilHRP(LP)
    if not hrp then return end
    StarterGui:SetCore("SendNotification", {Title="💥 BOOM!", Text="Gelombang meledak!", Duration=2})
    local origin = hrp.Position
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            local tHrp = ambilHRP(p)
            if tHrp then
                local dir = (tHrp.Position - origin).Unit
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = dir * 300 + Vector3.new(0, 200, 0)
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bv.Parent = tHrp
                game.Debris:AddItem(bv, 0.5)
            end
        end
    end
end)

buatPilihPemain(rusuhTab, "🌀 Muter Keliling Pemain (Ketuk nama)", function(player)
    States.orbitEnabled = not States.orbitEnabled
    States.orbitTarget = player
    StarterGui:SetCore("SendNotification", {Title="🌀 Muter", Text=States.orbitEnabled and ("Muter keliling "..player.Name) or "Berhenti muter", Duration=2})
end)

buatPilihPemain(rusuhTab, "🔗 Nempel ke Pemain (Ketuk nama)", function(player)
    States.attachEnabled = not States.attachEnabled
    States.attachTarget = player
    StarterGui:SetCore("SendNotification", {Title="🔗 Nempel", Text=States.attachEnabled and ("Nempel ke "..player.Name) or "Lepas", Duration=2})
end)

buatPilihPemain(rusuhTab, "🔄 Tukar Posisi (Ketuk nama)", function(player)
    local hrp = ambilHRP(LP)
    local tHrp = ambilHRP(player)
    if hrp and tHrp then
        local myPos = hrp.CFrame
        hrp.CFrame = tHrp.CFrame
        tHrp.CFrame = myPos
        StarterGui:SetCore("SendNotification", {Title="🔄 Tukar", Text="Posisi ditukar sama "..player.Name, Duration=2})
    end
end)

buatToggle(rusuhTab, "💬 Spam Chat", false, function(on)
    States.chatSpamEnabled = on
end)

buatTombol(rusuhTab, "🌪️ MODE KACAU BALAU ☠️", function()
    StarterGui:SetCore("SendNotification", {Title="☠️ KACAU BALAU", Text="SEMUA RUSUH DIAKTIFKAN!", Duration=3})
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            task.spawn(function() lemparPemain(p) end)
        end
    end
    task.wait(1)
    local hrp = ambilHRP(LP)
    if hrp then
        local origin = hrp.Position
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP then
                local tHrp = ambilHRP(p)
                if tHrp then
                    local dir = (tHrp.Position - origin).Unit
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = dir * 500 + Vector3.new(0, 300, 0)
                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bv.Parent = tHrp
                    game.Debris:AddItem(bv, 0.5)
                end
            end
        end
    end
    States.chatSpamEnabled = true
    task.delay(5, function() States.chatSpamEnabled = false end)
end)

-- ==========================================
-- TAB 5: 🌍 Hancur (RUSAK MAP!)
-- ==========================================

local function ambilSemuaParts()
    local parts = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local adalahPemain = false
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and obj:IsDescendantOf(p.Character) then
                    adalahPemain = true
                    break
                end
            end
            if not adalahPemain then
                table.insert(parts, obj)
            end
        end
    end
    return parts
end

buatTombol(hancurTab, "🧱 Lepas Semua Jangkar", function()
    StarterGui:SetCore("SendNotification", {Title="🧱", Text="Melepas jangkar semua objek...", Duration=2})
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function() part.Anchored = false end)
    end
end)

buatTombol(hancurTab, "🕳️ Hapus Lantai", function()
    StarterGui:SetCore("SendNotification", {Title="🕳️", Text="Lantai dihapus! Semua jatuh!", Duration=2})
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function()
            if part.Size.Y < 5 and part.Position.Y < 10 then
                part:Destroy()
            end
        end)
    end
end)

buatTombol(hancurTab, "💥 Ledakkan Map", function()
    StarterGui:SetCore("SendNotification", {Title="💥", Text="BOOM! Map meledak!", Duration=2})
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function()
            part.Anchored = false
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(math.random(-200,200), math.random(100,400), math.random(-200,200))
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Parent = part
            game.Debris:AddItem(bv, 1)
        end)
    end
end)

buatTombol(hancurTab, "🏚️ Hancurkan Map Total", function()
    StarterGui:SetCore("SendNotification", {Title="🏚️", Text="Map HANCUR TOTAL!", Duration=2})
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function() part:Destroy() end)
    end
end)

buatTombol(hancurTab, "🌀 Acak Posisi Objek", function()
    StarterGui:SetCore("SendNotification", {Title="🌀", Text="Semua objek diacak posisinya!", Duration=2})
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function()
            part.Anchored = false
            part.CFrame = part.CFrame * CFrame.new(math.random(-50,50), math.random(-10,30), math.random(-50,50))
        end)
    end
end)

buatTombol(hancurTab, "🔄 Putar Semua Objek", function()
    StarterGui:SetCore("SendNotification", {Title="🔄", Text="Semua objek muter-muter!", Duration=2})
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function()
            part.Anchored = false
            local bav = Instance.new("BodyAngularVelocity")
            bav.AngularVelocity = Vector3.new(math.random(-20,20), math.random(-20,20), math.random(-20,20))
            bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bav.Parent = part
            game.Debris:AddItem(bav, 5)
        end)
    end
end)

buatTombol(hancurTab, "⬆️ Lempar Objek ke Atas", function()
    StarterGui:SetCore("SendNotification", {Title="⬆️", Text="Semua objek terbang ke atas!", Duration=2})
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function()
            part.Anchored = false
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(0, math.random(200,600), 0)
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.Parent = part
            game.Debris:AddItem(bv, 1)
        end)
    end
end)

buatTombol(hancurTab, "🧲 Magnet Objek ke Sini", function()
    local hrp = ambilHRP(LP)
    if not hrp then return end
    StarterGui:SetCore("SendNotification", {Title="🧲", Text="Semua objek ketarik ke sini!", Duration=2})
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function()
            part.Anchored = false
            local bp = Instance.new("BodyPosition")
            bp.Position = hrp.Position
            bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bp.D = 500
            bp.P = 5000
            bp.Parent = part
            game.Debris:AddItem(bp, 3)
        end)
    end
end)

buatTombol(hancurTab, "📐 Ubah Ukuran Acak", function()
    StarterGui:SetCore("SendNotification", {Title="📐", Text="Objek berubah ukuran acak!", Duration=2})
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function()
            part.Size = part.Size * Vector3.new(math.random(1,5)/2, math.random(1,5)/2, math.random(1,5)/2)
        end)
    end
end)

buatTombol(hancurTab, "☠️ PENGHANCURAN TOTAL", function()
    StarterGui:SetCore("SendNotification", {Title="☠️ HANCUR", Text="SEMUANYA HANCUR LEBUR!", Duration=3})
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function() part.Anchored = false end)
    end
    task.wait(0.3)
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function()
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(math.random(-300,300), math.random(200,600), math.random(-300,300))
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Parent = part
            game.Debris:AddItem(bv, 1)
        end)
    end
    task.wait(2)
    for _, part in pairs(ambilSemuaParts()) do
        pcall(function() part:Destroy() end)
    end
end)

-- ==========================================
-- TAB 6: 🎭 Karakter
-- ==========================================

buatPilihPemain(karakterTab, "🎭 Salin Tampilan Pemain (Ketuk nama)", function(player)
    StarterGui:SetCore("SendNotification", {Title="🎭 Salin", Text="Menyalin tampilan "..player.Name.."...", Duration=2})
    pcall(function()
        local desc = Players:GetHumanoidDescriptionFromUserId(player.UserId)
        if desc then
            LP.Character:FindFirstChildOfClass("Humanoid"):ApplyDescription(desc)
            StarterGui:SetCore("SendNotification", {Title="🎭 Berhasil", Text="Sekarang kamu mirip "..player.Name.."!", Duration=2})
        end
    end)
end)

buatTombol(karakterTab, "🔄 Respawn Ulang", function()
    LP.Character:FindFirstChildOfClass("Humanoid").Health = 0
    StarterGui:SetCore("SendNotification", {Title="🔄", Text="Respawn ulang...", Duration=2})
end)

buatTombol(karakterTab, "🔙 Kembalikan Tampilan Asli", function()
    pcall(function()
        local desc = Players:GetHumanoidDescriptionFromUserId(LP.UserId)
        LP.Character:FindFirstChildOfClass("Humanoid"):ApplyDescription(desc)
        StarterGui:SetCore("SendNotification", {Title="🔙", Text="Tampilan dikembalikan!", Duration=2})
    end)
end)

-- ==========================================
-- TAB 7: 🛠️ Alat
-- ==========================================

buatToggle(alatTab, "🚫 Anti AFK", false, function(on)
    if on then
        local VirtualUser = game:GetService("VirtualUser")
        LP.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
        StarterGui:SetCore("SendNotification", {Title="🚫", Text="Anti AFK aktif!", Duration=2})
    end
end)

buatTombol(alatTab, "🌐 Pindah Server", function()
    StarterGui:SetCore("SendNotification", {Title="🌐", Text="Pindah server...", Duration=2})
    pcall(function()
        local servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, s in pairs(servers.data) do
            if s.id ~= game.JobId then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id)
                break
            end
        end
    end)
end)

buatTombol(alatTab, "🔄 Masuk Ulang", function()
    StarterGui:SetCore("SendNotification", {Title="🔄", Text="Masuk ulang server...", Duration=2})
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

buatTombol(alatTab, "📊 Info Server", function()
    local info = "Pemain: "..#Players:GetPlayers().."/"..Players.MaxPlayers
    info = info.."\nID Server: "..string.sub(game.JobId, 1, 8).."..."
    info = info.."\nID Tempat: "..game.PlaceId
    StarterGui:SetCore("SendNotification", {Title="📊 Info Server", Text=info, Duration=5})
end)

buatTombol(alatTab, "⏱️ Cek FPS", function()
    StarterGui:SetCore("SendNotification", {Title="⏱️ FPS", Text="FPS: "..math.floor(1/RunService.Heartbeat:Wait()), Duration=3})
end)

-- ==========================================
-- LOOP UTAMA
-- ==========================================

-- Kecepatan + Lompat
RunService.Heartbeat:Connect(function()
    local char = LP.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            if States.speedEnabled then
                hum.WalkSpeed = States.speedValue
            end
            if States.jumpEnabled then
                hum.JumpPower = States.jumpValue
                hum.UseJumpPower = true
            end
        end
    end
end)

-- Tembus Dinding
RunService.Stepped:Connect(function()
    if States.noclipEnabled then
        local char = LP.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Lompat Tanpa Batas
UserInputService.JumpRequest:Connect(function()
    if States.infJumpEnabled then
        local char = LP.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

-- Muter Keliling
RunService.Heartbeat:Connect(function()
    if States.orbitEnabled and States.orbitTarget then
        local hrp = ambilHRP(LP)
        local tHrp = ambilHRP(States.orbitTarget)
        if hrp and tHrp then
            local t = tick()
            local radius = 10
            local x = math.cos(t * 3) * radius
            local z = math.sin(t * 3) * radius
            hrp.CFrame = tHrp.CFrame * CFrame.new(x, 2, z)
        end
    end
end)

-- Nempel ke Pemain
RunService.Heartbeat:Connect(function()
    if States.attachEnabled and States.attachTarget then
        local hrp = ambilHRP(LP)
        local tHrp = ambilHRP(States.attachTarget)
        if hrp and tHrp then
            hrp.CFrame = tHrp.CFrame * CFrame.new(0, 0, -2)
        end
    end
end)

-- Spam Chat
task.spawn(function()
    while true do
        if States.chatSpamEnabled then
            pcall(function()
                local event = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                if event then
                    local sayMsg = event:FindFirstChild("SayMessageRequest")
                    if sayMsg then
                        sayMsg:FireServer(States.chatSpamText, "All")
                    end
                end
            end)
        end
        task.wait(0.8)
    end
end)

-- ==========================================
-- SELAMAT DATANG
-- ==========================================
StarterGui:SetCore("SendNotification", {
    Title = "⚡ Delta Admin V5 - MAP DESTROYER",
    Text = "✅ Berhasil dimuat! Ketuk ⚡ untuk buka panel\n🌍 7 Tab | 45+ Fitur | RUSUH TOTAL! 💀",
    Duration = 5
})

print("⚡ DELTA ADMIN V5 - MAP DESTROYER ⚡")
print("✅ Berhasil Dimuat!")
print("="..string.rep("=", 50).."=")
print("📍 Tab CP: Simpan & Kembali ke Titik")
print("👥 Tab Pemain: Teleport & Tarik Pemain")
print("🏃 Tab Gerak: Kecepatan, Lompat, Tembus Dinding, Inf Jump")
print("🤡 Tab Rusuh: Lempar, Tarik, Gelombang Kejut, KACAU BALAU")
print("🌍 Tab Hancur: FITUR RUSUH MAP (SEMUA LIHAT!)")
print("  🕳️ Hapus Lantai")
print("  💥 Ledakkan Map")
print("  🏚️ Hancurkan Total")
print("  🌀 Acak Posisi")
print("  🔄 Putar Objek")
print("  ⬆️ Terbang ke Atas")
print("  🧲 Magnet Objek")
print("  📐 Ubah Ukuran")
print("  ☠️ PENGHANCURAN TOTAL (ALL IN)")
print("🎭 Tab Karakter: Salin Tampilan, Respawn")
print("🛠️ Tab Alat: Anti AFK, Pindah Server, Info Server")
print("="..string.rep("=", 50).."=")
print("💀 SIAP NGANCUR TOTAL GANG! 💀")
