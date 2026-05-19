-- ===========================
-- ⚡ DELTA ADMIN V4 FINAL
-- Fix: All Executor Support
-- ===========================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Char, Hum, HRP

local flyOn = false
local flySpd = 60
local noclipOn = false
local savedCPs = {}
local BV, BG = nil, nil
local panelOpen = false

local function refreshChar()
    Char = LP.Character
    Hum = Char and Char:FindFirstChildWhichIsA("Humanoid")
    HRP = Char and Char:FindFirstChild("HumanoidRootPart")
end
refreshChar()

LP.CharacterAdded:Connect(function(c)
    Char = c
    Hum = c:WaitForChild("Humanoid")
    HRP = c:WaitForChild("HumanoidRootPart")
    flyOn = false
    BV = nil
    BG = nil
end)

-- SMART GUI (Support semua executor)
pcall(function() game:GetService("CoreGui"):FindFirstChild("DeltaV4F"):Destroy() end)
pcall(function() LP.PlayerGui:FindFirstChild("DeltaV4F"):Destroy() end)

local SG = Instance.new("ScreenGui")
SG.Name = "DeltaV4F"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local guiOK = pcall(function()
    SG.Parent = game:GetService("CoreGui")
end)
if not guiOK then
    pcall(function()
        if syn and syn.protect_gui then
            syn.protect_gui(SG)
        end
    end)
    pcall(function()
        if gethui then
            SG.Parent = gethui()
        else
            SG.Parent = LP:WaitForChild("PlayerGui")
        end
    end)
    if not SG.Parent then
        SG.Parent = LP:WaitForChild("PlayerGui")
    end
end

-- NOTIF
local function notify(msg)
    pcall(function() SG:FindFirstChild("NTF"):Destroy() end)
    local n = Instance.new("TextLabel")
    n.Name = "NTF"
    n.Size = UDim2.new(0,240,0,34)
    n.Position = UDim2.new(0.5,-120,0,-40)
    n.BackgroundColor3 = Color3.fromRGB(30,50,150)
    n.TextColor3 = Color3.new(1,1,1)
    n.Text = msg
    n.TextSize = 11
    n.Font = Enum.Font.GothamBold
    n.TextWrapped = true
    n.ZIndex = 100
    n.Parent = SG
    Instance.new("UICorner",n).CornerRadius = UDim.new(0,10)
    TweenService:Create(n,TweenInfo.new(0.3),{Position=UDim2.new(0.5,-120,0,8)}):Play()
    task.delay(2.5,function()
        TweenService:Create(n,TweenInfo.new(0.3),{Position=UDim2.new(0.5,-120,0,-50)}):Play()
        task.delay(0.4,function() pcall(function() n:Destroy() end) end)
    end)
end

-- DRAG
local function makeDrag(handle, target)
    local dragging, dragStart, startPos = false, nil, nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch
        or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = Vector2.new(i.Position.X, i.Position.Y)
            startPos = target.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if not dragging then return end
        if i.UserInputType == Enum.UserInputType.Touch
        or i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = Vector2.new(i.Position.X, i.Position.Y) - dragStart
            target.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch
        or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- TOGGLE BUTTON
local Tog = Instance.new("TextButton")
Tog.Size = UDim2.new(0,44,0,44)
Tog.Position = UDim2.new(0,8,0.45,0)
Tog.BackgroundColor3 = Color3.fromRGB(20,20,35)
Tog.TextColor3 = Color3.new(1,1,1)
Tog.Text = "⚡"
Tog.TextSize = 20
Tog.Font = Enum.Font.GothamBold
Tog.ZIndex = 30
Tog.AutoButtonColor = false
Tog.Parent = SG
Instance.new("UICorner",Tog).CornerRadius = UDim.new(1,0)
local togS = Instance.new("UIStroke",Tog)
togS.Color = Color3.fromRGB(80,120,255)
togS.Thickness = 2

-- PANEL
local P = Instance.new("Frame")
P.Name = "Panel"
P.Size = UDim2.new(0,300,0,400)
P.Position = UDim2.new(0.5,-150,0.5,-200)
P.BackgroundColor3 = Color3.fromRGB(14,14,24)
P.Visible = false
P.ZIndex = 10
P.Parent = SG
Instance.new("UICorner",P).CornerRadius = UDim.new(0,12)
local pSt = Instance.new("UIStroke",P)
pSt.Color = Color3.fromRGB(70,100,255)
pSt.Thickness = 2

-- Toggle button: drag + tap
do
    local dragging, dragStart, startPos = false, nil, nil
    local moved = false
    Tog.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch
        or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            moved = false
            dragStart = Vector2.new(i.Position.X, i.Position.Y)
            startPos = Tog.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if not dragging then return end
        if i.UserInputType == Enum.UserInputType.Touch
        or i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = Vector2.new(i.Position.X, i.Position.Y) - dragStart
            if d.Magnitude > 6 then moved = true end
            if moved then
                Tog.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + d.X,
                    startPos.Y.Scale, startPos.Y.Offset + d.Y
                )
            end
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch
        or i.UserInputType == Enum.UserInputType.MouseButton1 then
            if dragging and not moved then
                panelOpen = not panelOpen
                P.Visible = panelOpen
            end
            dragging = false
        end
    end)
end

-- TITLE BAR
local TB = Instance.new("Frame")
TB.Size = UDim2.new(1,0,0,36)
TB.BackgroundColor3 = Color3.fromRGB(28,48,160)
TB.ZIndex = 11
TB.Parent = P
Instance.new("UICorner",TB).CornerRadius = UDim.new(0,12)

local TBbot = Instance.new("Frame")
TBbot.Size = UDim2.new(1,0,0,14)
TBbot.Position = UDim2.new(0,0,1,-14)
TBbot.BackgroundColor3 = Color3.fromRGB(28,48,160)
TBbot.BorderSizePixel = 0
TBbot.ZIndex = 11
TBbot.Parent = TB

local TL = Instance.new("TextLabel")
TL.Size = UDim2.new(1,-40,1,0)
TL.Position = UDim2.new(0,10,0,0)
TL.BackgroundTransparency = 1
TL.Text = "⚡ Delta Admin V4"
TL.TextColor3 = Color3.new(1,1,1)
TL.TextSize = 13
TL.Font = Enum.Font.GothamBold
TL.TextXAlignment = Enum.TextXAlignment.Left
TL.ZIndex = 12
TL.Parent = TB

local XB = Instance.new("TextButton")
XB.Size = UDim2.new(0,28,0,28)
XB.Position = UDim2.new(1,-34,0.5,-14)
XB.BackgroundColor3 = Color3.fromRGB(180,40,40)
XB.Text = "✕"
XB.TextColor3 = Color3.new(1,1,1)
XB.TextSize = 13
XB.Font = Enum.Font.GothamBold
XB.ZIndex = 13
XB.Parent = TB
Instance.new("UICorner",XB).CornerRadius = UDim.new(1,0)
XB.MouseButton1Click:Connect(function() panelOpen=false P.Visible=false end)
makeDrag(TB, P)

-- TAB SYSTEM
local TBar = Instance.new("Frame")
TBar.Size = UDim2.new(1,-10,0,28)
TBar.Position = UDim2.new(0,5,0,40)
TBar.BackgroundTransparency = 1
TBar.ZIndex = 11
TBar.Parent = P
local tlay = Instance.new("UIListLayout",TBar)
tlay.FillDirection = Enum.FillDirection.Horizontal
tlay.Padding = UDim.new(0,3)

local tNames = {"CP","Players","Move"}
local tBtns = {}
local tFrm = {}

for i,nm in ipairs(tNames) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0,93,1,0)
    b.BackgroundColor3 = Color3.fromRGB(25,25,42)
    b.TextColor3 = Color3.fromRGB(150,150,170)
    b.Text = nm
    b.TextSize = 11
    b.Font = Enum.Font.GothamBold
    b.LayoutOrder = i
    b.ZIndex = 12
    b.Parent = TBar
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
    tBtns[nm] = b

    local sf = Instance.new("ScrollingFrame")
    sf.Size = UDim2.new(1,-10,1,-76)
    sf.Position = UDim2.new(0,5,0,72)
    sf.BackgroundTransparency = 1
    sf.ScrollBarThickness = 3
    sf.ScrollBarImageColor3 = Color3.fromRGB(80,120,255)
    sf.BorderSizePixel = 0
    sf.CanvasSize = UDim2.new(0,0,0,0)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sf.Visible = (i==1)
    sf.ZIndex = 11
    sf.Parent = P
    Instance.new("UIListLayout",sf).Padding = UDim.new(0,4)
    sf:FindFirstChild("UIListLayout").SortOrder = Enum.SortOrder.LayoutOrder
    tFrm[nm] = sf
end

local function goTab(nm)
    for n,b in pairs(tBtns) do
        b.BackgroundColor3 = n==nm and Color3.fromRGB(50,80,220) or Color3.fromRGB(25,25,42)
        b.TextColor3 = n==nm and Color3.new(1,1,1) or Color3.fromRGB(150,150,170)
    end
    for n,f in pairs(tFrm) do f.Visible=(n==nm) end
end
for n,b in pairs(tBtns) do b.MouseButton1Click:Connect(function() goTab(n) end) end
goTab("CP")

-- UI HELPERS
local function mkL(p,t,o)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,0,0,18)
    l.BackgroundTransparency = 1
    l.Text = "  "..t
    l.TextColor3 = Color3.fromRGB(80,130,255)
    l.TextSize = 10
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.LayoutOrder = o or 0
    l.ZIndex = 12
    l.Parent = p
end

local function mkB(p,t,c,cb,o)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,0,0,32)
    b.BackgroundColor3 = c
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = t
    b.TextSize = 11
    b.Font = Enum.Font.GothamSemibold
    b.LayoutOrder = o or 0
    b.ZIndex = 12
    b.Parent = p
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
    b.MouseButton1Click:Connect(cb)
    return b
end

local function mkT(p,t,df,cb,o)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,32)
    f.BackgroundColor3 = Color3.fromRGB(22,22,38)
    f.BorderSizePixel = 0
    f.LayoutOrder = o or 0
    f.ZIndex = 12
    f.Parent = p
    Instance.new("UICorner",f).CornerRadius = UDim.new(0,8)

    local lb = Instance.new("TextLabel")
    lb.Size = UDim2.new(1,-56,1,0)
    lb.Position = UDim2.new(0,8,0,0)
    lb.BackgroundTransparency = 1
    lb.Text = t
    lb.TextColor3 = Color3.new(1,1,1)
    lb.TextSize = 11
    lb.Font = Enum.Font.GothamSemibold
    lb.TextXAlignment = Enum.TextXAlignment.Left
    lb.ZIndex = 13
    lb.Parent = f

    local bg = Instance.new("TextButton")
    bg.Size = UDim2.new(0,38,0,20)
    bg.Position = UDim2.new(1,-44,0.5,-10)
    bg.BackgroundColor3 = df and Color3.fromRGB(50,100,255) or Color3.fromRGB(50,50,70)
    bg.Text = ""
    bg.ZIndex = 13
    bg.Parent = f
    Instance.new("UICorner",bg).CornerRadius = UDim.new(1,0)

    local dt = Instance.new("Frame")
    dt.Size = UDim2.new(0,16,0,16)
    dt.Position = df and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
    dt.BackgroundColor3 = Color3.new(1,1,1)
    dt.ZIndex = 14
    dt.Parent = bg
    Instance.new("UICorner",dt).CornerRadius = UDim.new(1,0)

    local st = df
    bg.MouseButton1Click:Connect(function()
        st = not st
        TweenService:Create(bg,TweenInfo.new(0.2),{
            BackgroundColor3 = st and Color3.fromRGB(50,100,255) or Color3.fromRGB(50,50,70)
        }):Play()
        TweenService:Create(dt,TweenInfo.new(0.2),{
            Position = st and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
        }):Play()
        cb(st)
    end)
end

local function mkS(p,t,mn,mx,df,cb,o)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,48)
    f.BackgroundColor3 = Color3.fromRGB(22,22,38)
    f.BorderSizePixel = 0
    f.LayoutOrder = o or 0
    f.ZIndex = 12
    f.Parent = p
    Instance.new("UICorner",f).CornerRadius = UDim.new(0,8)

    local lb = Instance.new("TextLabel")
    lb.Size = UDim2.new(1,-10,0,18)
    lb.Position = UDim2.new(0,8,0,2)
    lb.BackgroundTransparency = 1
    lb.Text = t..": "..df
    lb.TextColor3 = Color3.new(1,1,1)
    lb.TextSize = 10
    lb.Font = Enum.Font.GothamSemibold
    lb.TextXAlignment = Enum.TextXAlignment.Left
    lb.ZIndex = 13
    lb.Parent = f

    local tk = Instance.new("Frame")
    tk.Size = UDim2.new(1,-16,0,10)
    tk.Position = UDim2.new(0,8,0,28)
    tk.BackgroundColor3 = Color3.fromRGB(40,40,65)
    tk.ZIndex = 13
    tk.Parent = f
    Instance.new("UICorner",tk).CornerRadius = UDim.new(1,0)

    local fl = Instance.new("Frame")
    fl.Size = UDim2.new((df-mn)/(mx-mn),0,1,0)
    fl.BackgroundColor3 = Color3.fromRGB(60,100,255)
    fl.ZIndex = 14
    fl.Parent = tk
    Instance.new("UICorner",fl).CornerRadius = UDim.new(1,0)

    local kb = Instance.new("Frame")
    kb.Size = UDim2.new(0,16,0,16)
    kb.Position = UDim2.new((df-mn)/(mx-mn),-8,0.5,-8)
    kb.BackgroundColor3 = Color3.new(1,1,1)
    kb.ZIndex = 15
    kb.Parent = tk
    Instance.new("UICorner",kb).CornerRadius = UDim.new(1,0)

    local sliding = false
    local function upd(x)
        local r = math.clamp((x - tk.AbsolutePosition.X) / tk.AbsoluteSize.X, 0, 1)
        fl.Size = UDim2.new(r,0,1,0)
        kb.Position = UDim2.new(r,-8,0.5,-8)
        local v = math.floor(mn + (mx-mn)*r)
        lb.Text = t..": "..v
        cb(v)
    end

    tk.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch
        or i.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = true
            upd(i.Position.X)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if sliding and (i.UserInputType == Enum.UserInputType.Touch
        or i.UserInputType == Enum.UserInputType.MouseMovement) then
            upd(i.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch
        or i.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = false
        end
    end)
end
-- ===========================
-- 📍 CP TAB
-- ===========================
local CPT = tFrm["CP"]
mkL(CPT,"📌 CHECKPOINTS",1)

local cpH = Instance.new("Frame")
cpH.Size = UDim2.new(1,0,0,0)
cpH.AutomaticSize = Enum.AutomaticSize.Y
cpH.BackgroundTransparency = 1
cpH.LayoutOrder = 3
cpH.Parent = CPT
Instance.new("UIListLayout",cpH).Padding = UDim.new(0,4)

mkB(CPT,"💾 Save Position",Color3.fromRGB(25,70,25),function()
    refreshChar()
    if not HRP then notify("❌ No character") return end
    local n = #savedCPs + 1
    local cf = HRP.CFrame
    table.insert(savedCPs, cf)

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,0,0,30)
    row.BackgroundColor3 = Color3.fromRGB(20,35,20)
    row.ZIndex = 13
    row.Parent = cpH
    Instance.new("UICorner",row).CornerRadius = UDim.new(0,7)

    local rl = Instance.new("TextLabel")
    rl.Size = UDim2.new(1,-74,1,0)
    rl.Position = UDim2.new(0,8,0,0)
    rl.BackgroundTransparency = 1
    rl.Text = "📍 CP "..n
    rl.TextColor3 = Color3.fromRGB(100,220,100)
    rl.TextSize = 10
    rl.Font = Enum.Font.GothamSemibold
    rl.TextXAlignment = Enum.TextXAlignment.Left
    rl.ZIndex = 14
    rl.Parent = row

    local tpb = Instance.new("TextButton")
    tpb.Size = UDim2.new(0,30,0,22)
    tpb.Position = UDim2.new(1,-66,0.5,-11)
    tpb.BackgroundColor3 = Color3.fromRGB(40,80,200)
    tpb.Text = "TP"
    tpb.TextColor3 = Color3.new(1,1,1)
    tpb.TextSize = 9
    tpb.Font = Enum.Font.GothamBold
    tpb.ZIndex = 14
    tpb.Parent = row
    Instance.new("UICorner",tpb).CornerRadius = UDim.new(0,6)
    tpb.MouseButton1Click:Connect(function()
        refreshChar()
        if HRP then HRP.CFrame = cf notify("✅ TP CP "..n) end
    end)

    local dlb = Instance.new("TextButton")
    dlb.Size = UDim2.new(0,30,0,22)
    dlb.Position = UDim2.new(1,-32,0.5,-11)
    dlb.BackgroundColor3 = Color3.fromRGB(150,30,30)
    dlb.Text = "✕"
    dlb.TextColor3 = Color3.new(1,1,1)
    dlb.TextSize = 9
    dlb.Font = Enum.Font.GothamBold
    dlb.ZIndex = 14
    dlb.Parent = row
    Instance.new("UICorner",dlb).CornerRadius = UDim.new(0,6)
    dlb.MouseButton1Click:Connect(function() row:Destroy() end)

    notify("💾 CP "..n.." Saved!")
end,2)

mkB(CPT,"🗑️ Clear All",Color3.fromRGB(80,25,25),function()
    savedCPs = {}
    for _,c in pairs(cpH:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
    notify("🗑️ Cleared!")
end,4)

-- ===========================
-- 👥 PLAYERS TAB
-- ===========================
local PLT = tFrm["Players"]
mkL(PLT,"👥 PLAYER LIST",1)

local plH = Instance.new("Frame")
plH.Size = UDim2.new(1,0,0,0)
plH.AutomaticSize = Enum.AutomaticSize.Y
plH.BackgroundTransparency = 1
plH.LayoutOrder = 3
plH.Parent = PLT
Instance.new("UIListLayout",plH).Padding = UDim.new(0,5)

local function buildPL()
    for _,c in pairs(plH:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
    for _,plr in pairs(Players:GetPlayers()) do
        if plr == LP then continue end

        local card = Instance.new("Frame")
        card.Size = UDim2.new(1,0,0,50)
        card.BackgroundColor3 = Color3.fromRGB(20,20,36)
        card.ZIndex = 13
        card.Parent = plH
        Instance.new("UICorner",card).CornerRadius = UDim.new(0,8)

        local ab = Instance.new("Frame")
        ab.Size = UDim2.new(0,34,0,34)
        ab.Position = UDim2.new(0,6,0.5,-17)
        ab.BackgroundColor3 = Color3.fromRGB(40,40,60)
        ab.ZIndex = 14
        ab.Parent = card
        Instance.new("UICorner",ab).CornerRadius = UDim.new(1,0)

        local ai = Instance.new("ImageLabel")
        ai.Size = UDim2.new(1,0,1,0)
        ai.BackgroundTransparency = 1
        ai.ZIndex = 15
        ai.Parent = ab
        Instance.new("UICorner",ai).CornerRadius = UDim.new(1,0)
        task.spawn(function()
            pcall(function()
                local img = Players:GetUserThumbnailAsync(
                    plr.UserId,
                    Enum.ThumbnailType.HeadShot,
                    Enum.ThumbnailSize.Size100x100
                )
                ai.Image = img
            end)
        end)

        local dn = Instance.new("TextLabel")
        dn.Size = UDim2.new(1,-120,0,16)
        dn.Position = UDim2.new(0,46,0,6)
        dn.BackgroundTransparency = 1
        dn.Text = plr.DisplayName
        dn.TextColor3 = Color3.new(1,1,1)
        dn.TextSize = 11
        dn.Font = Enum.Font.GothamBold
        dn.TextXAlignment = Enum.TextXAlignment.Left
        dn.TextTruncate = Enum.TextTruncate.AtEnd
        dn.ZIndex = 14
        dn.Parent = card

        local un = Instance.new("TextLabel")
        un.Size = UDim2.new(1,-120,0,12)
        un.Position = UDim2.new(0,46,0,23)
        un.BackgroundTransparency = 1
        un.Text = "@"..plr.Name
        un.TextColor3 = Color3.fromRGB(100,100,130)
        un.TextSize = 9
        un.Font = Enum.Font.Gotham
        un.TextXAlignment = Enum.TextXAlignment.Left
        un.TextTruncate = Enum.TextTruncate.AtEnd
        un.ZIndex = 14
        un.Parent = card

        local tpb = Instance.new("TextButton")
        tpb.Size = UDim2.new(0,34,0,26)
        tpb.Position = UDim2.new(1,-76,0.5,-13)
        tpb.BackgroundColor3 = Color3.fromRGB(40,80,200)
        tpb.Text = "🚀"
        tpb.TextSize = 13
        tpb.ZIndex = 14
        tpb.Parent = card
        Instance.new("UICorner",tpb).CornerRadius = UDim.new(0,7)
        tpb.MouseButton1Click:Connect(function()
            pcall(function()
                refreshChar()
                local tc = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if HRP and tc then
                    HRP.CFrame = tc.CFrame * CFrame.new(0,0,3)
                    notify("🚀 TP → "..plr.Name)
                else
                    notify("❌ Not found")
                end
            end)
        end)

        local pb = Instance.new("TextButton")
        pb.Size = UDim2.new(0,34,0,26)
        pb.Position = UDim2.new(1,-38,0.5,-13)
        pb.BackgroundColor3 = Color3.fromRGB(160,40,40)
        pb.Text = "🧲"
        pb.TextSize = 13
        pb.ZIndex = 14
        pb.Parent = card
        Instance.new("UICorner",pb).CornerRadius = UDim.new(0,7)
        pb.MouseButton1Click:Connect(function()
            pcall(function()
                refreshChar()
                local tc = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if HRP and tc then
                    tc.CFrame = HRP.CFrame * CFrame.new(0,0,3)
                    notify("🧲 Pulled "..plr.Name)
                else
                    notify("❌ Not found")
                end
            end)
        end)
    end
end

mkB(PLT,"🔄 Refresh",Color3.fromRGB(30,40,80),function()
    buildPL()
    notify("🔄 Refreshed")
end,2)

buildPL()
Players.PlayerAdded:Connect(function() task.wait(1) buildPL() end)
Players.PlayerRemoving:Connect(function() task.wait(0.5) buildPL() end)
-- ===========================
-- 🏃 MOVEMENT TAB
-- ===========================
local MVT = tFrm["Move"]

mkL(MVT,"🦘 JUMP POWER",1)
mkS(MVT,"Jump",50,800,50,function(v)
    refreshChar()
    if Hum then Hum.UseJumpPower = true Hum.JumpPower = v end
end,2)

mkL(MVT,"🏃 SPEED",3)
mkS(MVT,"Speed",16,500,16,function(v)
    refreshChar()
    if Hum then Hum.WalkSpeed = v end
end,4)

mkL(MVT,"✈️ FLY (Geser Layar)",5)

-- ===========================
-- FLY SYSTEM
-- Geser layar atas = naik
-- Geser layar bawah = turun
-- Geser kanan/kiri = belok
-- Joystick = maju/mundur ikut kamera
-- ===========================
local function startFly()
    refreshChar()
    if not HRP or not Hum then notify("❌ No character") return end

    pcall(function()
        if HRP:FindFirstChild("FlyBV") then HRP.FlyBV:Destroy() end
        if HRP:FindFirstChild("FlyBG") then HRP.FlyBG:Destroy() end
    end)

    Hum.PlatformStand = true

    BV = Instance.new("BodyVelocity")
    BV.Name = "FlyBV"
    BV.Velocity = Vector3.zero
    BV.MaxForce = Vector3.new(9e9,9e9,9e9)
    BV.P = 1250
    BV.Parent = HRP

    BG = Instance.new("BodyGyro")
    BG.Name = "FlyBG"
    BG.P = 9e4
    BG.MaxTorque = Vector3.new(9e9,9e9,9e9)
    BG.CFrame = HRP.CFrame
    BG.Parent = HRP

    notify("✈️ Fly ON! Geser layar = arah terbang")
end

local function stopFly()
    pcall(function()
        if BV then BV:Destroy() end
        if BG then BG:Destroy() end
    end)
    BV = nil
    BG = nil
    refreshChar()
    pcall(function()
        if HRP then
            if HRP:FindFirstChild("FlyBV") then HRP.FlyBV:Destroy() end
            if HRP:FindFirstChild("FlyBG") then HRP.FlyBG:Destroy() end
        end
    end)
    if Hum then Hum.PlatformStand = false end
    notify("✈️ Fly OFF")
end

mkT(MVT,"✈️ Enable Fly",false,function(s)
    flyOn = s
    if s then startFly() else stopFly() end
end,6)

mkS(MVT,"Fly Speed",10,400,60,function(v) flySpd = v end,7)

-- Info
local infoL = Instance.new("TextLabel")
infoL.Size = UDim2.new(1,0,0,44)
infoL.BackgroundColor3 = Color3.fromRGB(18,18,32)
infoL.TextColor3 = Color3.fromRGB(150,180,255)
infoL.Text = "📱 Geser layar atas/bawah = naik/turun\n🕹️ Joystick = maju/mundur/kiri/kanan\n⌨️ PC: WASD + Space/Shift"
infoL.TextSize = 9
infoL.Font = Enum.Font.Gotham
infoL.TextWrapped = true
infoL.LayoutOrder = 8
infoL.ZIndex = 12
infoL.Parent = MVT
Instance.new("UICorner",infoL).CornerRadius = UDim.new(0,8)

mkL(MVT,"👻 NOCLIP",9)
mkT(MVT,"👻 No Clip",false,function(s)
    noclipOn = s
    notify(s and "👻 Noclip ON" or "👻 Noclip OFF")
end,10)

-- ===========================
-- MAIN LOOP
-- ===========================
RunService.RenderStepped:Connect(function()

    -- FLY
    if flyOn and BV and BG then
        refreshChar()
        if not HRP then return end

        local cam = workspace.CurrentCamera
        local camCF = cam.CFrame
        local dir = Vector3.zero

        -- PC keyboard
        pcall(function()
            if UIS:IsKeyDown(Enum.KeyCode.W) then
                dir = dir + camCF.LookVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.S) then
                dir = dir - camCF.LookVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.A) then
                dir = dir - camCF.RightVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.D) then
                dir = dir + camCF.RightVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then
                dir = dir + Vector3.new(0,1,0)
            end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                dir = dir - Vector3.new(0,1,0)
            end
        end)

        -- Mobile joystick + kamera
        -- Joystick maju = ikut LookVector kamera (termasuk naik/turun)
        -- Geser layar keatas = kamera nunduk = LookVector.Y naik = terbang naik
        pcall(function()
            if Hum and Hum.MoveDirection.Magnitude > 0.1 then
                local md = Hum.MoveDirection
                local forward = camCF.LookVector
                local right = camCF.RightVector
                dir = dir + (forward * -md.Z) + (right * md.X)
            end
        end)

        -- Apply
        if dir.Magnitude > 0 then
            BV.Velocity = dir.Unit * flySpd
        else
            BV.Velocity = Vector3.zero
        end

        -- Karakter hadap arah kamera (horizontal)
        local flatLook = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z)
        if flatLook.Magnitude > 0 then
            BG.CFrame = CFrame.new(HRP.Position, HRP.Position + flatLook)
        end
    end

    -- NOCLIP
    if noclipOn then
        pcall(function()
            refreshChar()
            if Char then
                for _,p in pairs(Char:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    end
end)

-- DONE
notify("⚡ Delta Admin V4 Loaded!")
print("✅ Delta Admin V4 Final - All Executor Support")
print("⚡ Tap tombol ⚡ untuk buka panel")
