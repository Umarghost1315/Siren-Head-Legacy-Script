local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SIREN HEAD: LEGACY",
   LoadingTitle = "Loading",
   LoadingSubtitle = "by Umarghost1315",
   ConfigurationSaving = {
      Enabled = false 
   },
   KeySystem = false 
})

local Tab = Window:CreateTab("Player", 0)

local Players = game:GetService("Players") 
local LocalPlayer = Players.LocalPlayer

local TargetSpeed = 16
local TargetJump = 50

task.spawn(function()
    while task.wait(0.1) do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            
            humanoid.WalkSpeed = TargetSpeed
            humanoid.UseJumpPower = true
            humanoid.JumpPower = TargetJump
        end
    end
end)

local Slider = Tab:CreateSlider({
   Name = "WalkSpeed",
   Range = {1, 35},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider", 
   Callback = function(Value)
       TargetSpeed = Value
   end,
})

task.spawn(function()
   while true do
       local Player = game.Players.LocalPlayer
       local Character = Player and Player.Character
       local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
       
       if Humanoid and Humanoid.WalkSpeed ~= TargetSpeed then
           Humanoid.WalkSpeed = TargetSpeed
       end
       
       task.wait()
   end
end)

local Slider = Tab:CreateSlider({
   Name = "JumpPower",
   Range = {1, 100},
   Increment = 1,
   Suffix = "Jump",
   CurrentValue = 50,
   Flag = "JumpSlider", 
   Callback = function(Value)
       TargetJump = Value
   end,
})

task.spawn(function()
   while true do
       local Player = game.Players.LocalPlayer
       local Character = Player and Player.Character
       local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
       
       if Humanoid and Humanoid.JumpPower ~= TargetJump then
           Humanoid.JumpPower = TargetJump 
       end
       
       task.wait()
   end
end)


local BlinkDistance = 5

Tab:CreateSlider({
   Name = "Blink",
   Range = {1, 10},
   Increment = 1,
   Suffix = "studs",
   CurrentValue = 5,
   Flag = "BlinkDistanceSlider", 
   Callback = function(Value)
       BlinkDistance = Value
   end,
})

Tab:CreateKeybind({
   Name = "Teleport key",
   CurrentKeybind = "E", 
   HoldToInteract = false,
   Flag = "BlinkKeybind", 
   Callback = function()
       local Player = game.Players.LocalPlayer
       local Character = Player.Character
       local Root = Character and Character:FindFirstChild("HumanoidRootPart")
       
       if Root then
           Root.CFrame = Root.CFrame * CFrame.new(0, 0, -BlinkDistance)
       end
   end,
})

Tab:CreateKeybind({
   Name = "Physical surge (Bypass)",
   CurrentKeybind = "E",
   HoldToInteract = false,
   Flag = "BlinkVelocityKeybind", 
   Callback = function()
       local Player = game.Players.LocalPlayer
       local Character = Player.Character
       local Root = Character and Character:FindFirstChild("HumanoidRootPart")
       
       if Root then
           local Velocity = Instance.new("BodyVelocity")
           Velocity.MaxForce = Vector3.new(math.huge, 0, math.huge)
           
           Velocity.Velocity = Root.CFrame.LookVector * (BlinkDistance * 15) 
           Velocity.Parent = Root
           
           task.wait(0.1)
           Velocity:Destroy()
       end
   end,
})

local Tab = Window:CreateTab("Gun", 0)

local originalAmmo = {}

local Toggle = Tab:CreateToggle({
   Name = "InfAmmo",
   CurrentValue = false,
   Flag = "AllWeaponsAmmoToggle",
   Callback = function(Value)
       _G.AllInfAmmoActive = Value
       
       if Value then
           task.spawn(function()
               while _G.AllInfAmmoActive do
                   local Player = game.Players.LocalPlayer
                   local Character = Player.Character
                   local ActiveWeapon = Character and Character:FindFirstChildOfClass("Tool")
                   
                   if ActiveWeapon then
                       for _, child in pairs(ActiveWeapon:GetDescendants()) do
                           if child:IsA("IntValue") or child:IsA("NumberValue") then
                               local name = child.Name:lower()
                               
                               if name:find("mag") or name:find("ammo") then
                                   
                                   if not originalAmmo[child] then
                                       originalAmmo[child] = child.Value
                                   end
                                   child.Value = 99 
                               end
                           end
                       end
                   end
                   task.wait(0.1)
               end
           end)
       else
           for child, oldValue in pairs(originalAmmo) do
               if child and child.Parent then
                   child.Value = oldValue
               end
           end
           originalAmmo = {}
       end
   end,
})

local originalDelays = {}

local Toggle = Tab:CreateToggle({
   Name = "No Delay",
   CurrentValue = false,
   Flag = "NoDelayToggle",
   Callback = function(Value)
       _G.NoDelayActive = Value
       
       if Value then
           task.spawn(function()
               while _G.NoDelayActive do
                   local ActiveWeapon = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                   if ActiveWeapon then
                       for _, child in pairs(ActiveWeapon:GetDescendants()) do
                           if child:IsA("IntValue") or child:IsA("NumberValue") then
                               local name = child.Name:lower()
                               if name:find("delay") or name:find("cooldown") or name:find("firerate") then
                                   
                                   if not originalDelays[child] then
                                       originalDelays[child] = child.Value
                                   end
                                   child.Value = 0
                               end
                           end
                       end
                   end
                   task.wait(0.1)
               end
           end)
       else
           for child, oldValue in pairs(originalDelays) do
               if child and child.Parent then
                   child.Value = oldValue
               end
           end
           originalDelays = {}
       end
   end,
})


local originalRanges = {}

local Toggle = Tab:CreateToggle({
   Name = "Inf Range",
   CurrentValue = false,
   Flag = "InfRangeToggle",
   Callback = function(Value)
       _G.InfRangeActive = Value
       
       if Value then
           task.spawn(function()
               while _G.InfRangeActive do
                   local ActiveWeapon = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                   if ActiveWeapon then
                       for _, child in pairs(ActiveWeapon:GetDescendants()) do
                           if child:IsA("IntValue") or child:IsA("NumberValue") then
                               local name = child.Name:lower()
                               if name:find("range") or name:find("distance") then
                                   if not originalRanges[child] then
                                       originalRanges[child] = child.Value
                                   end
                                   child.Value = 999
                               end
                           end
                       end
                   end
                   task.wait(0.1)
               end
           end)
       else
           for child, oldValue in pairs(originalRanges) do
               if child and child.Parent then
                   child.Value = oldValue
               end
           end
           originalRanges = {}
       end
   end,
})


local originalRecoilAndSpread = {}

_G.NoRecoilAndSpread = false

Tab:CreateToggle({
   Name = "No Recoil & Spread",
   CurrentValue = false,
   Flag = "RecoilSpreadToggle",
   Callback = function(Value)
       _G.NoRecoilAndSpread = Value
       
       if Value then
           task.spawn(function()
               while _G.NoRecoilAndSpread do
                   local Player = game.Players.LocalPlayer
                   local ActiveWeapon = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
                   
                   if ActiveWeapon then
                       for _, child in pairs(ActiveWeapon:GetDescendants()) do
                           if child:IsA("IntValue") or child:IsA("NumberValue") then
                               local name = child.Name:lower()
                               
                               if name:find("recoil") or name:find("kick") or name:find("spread") or name:find("accuracy") then
                                   if not originalRecoilAndSpread[child] then
                                       originalRecoilAndSpread[child] = child.Value
                                   end
                                   child.Value = 0
                               end
                           end
                       end
                   end
                   task.wait(0.1)
               end
           end)
       else
           for child, oldValue in pairs(originalRecoilAndSpread) do
               if child and child.Parent then
                   child.Value = oldValue
               end
           end
           originalRecoilAndSpread = {}
       end
   end,
})


local Tab = Window:CreateTab("Esp", 0)

local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

_G.PlayerEspActive = false
_G.PlayerEspDistance = 50
_G.PlayerShowTracers = true

local playerDrawings = {}

local function removePlayerESP(player)
    if playerDrawings[player] then
        local data = playerDrawings[player]
        if data.Text then data.Text.Visible = false; data.Text:Destroy() end
        if data.Line then data.Line.Visible = false; data.Line:Destroy() end
        playerDrawings[player] = nil
    end
end

local function createPlayerESP(player)
    if player == LocalPlayer or playerDrawings[player] then return end

    local text = Drawing.new("Text")
    text.Visible = false
    text.Size = 14
    text.Center = true
    text.Outline = true
    text.Color = Color3.fromRGB(0, 255, 255)

    local line = Drawing.new("Line")
    line.Visible = false
    line.Thickness = 1.5
    line.Color = Color3.fromRGB(0, 255, 255)

    playerDrawings[player] = {Text = text, Line = line}
end

for _, p in pairs(Players:GetPlayers()) do createPlayerESP(p) end
Players.PlayerAdded:Connect(createPlayerESP)
Players.PlayerRemoving:Connect(removePlayerESP)

RunService.RenderStepped:Connect(function()
    if not _G.PlayerEspActive then
        for _, data in pairs(playerDrawings) do 
            data.Text.Visible = false
            data.Line.Visible = false
        end
        return
    end

    local localCharacter = LocalPlayer.Character
    local localHrp = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")

    for player, data in pairs(playerDrawings) do
        local character = player.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        local hum = character and character:FindFirstChildOfClass("Humanoid")

        if not hrp or not hum or hum.Health <= 0 then
            data.Text.Visible = false
            data.Line.Visible = false
        elseif localHrp then
            local distance = (localHrp.Position - hrp.Position).Magnitude

            if distance <= _G.PlayerEspDistance then
                local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                
                if onScreen then
                    data.Text.Position = Vector2.new(vector.X, vector.Y - 30)
                    data.Text.Text = string.format("👤 %s [%dм]", player.Name, distance)
                    data.Text.Visible = true

                    if _G.PlayerShowTracers then
                        data.Line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        data.Line.To = Vector2.new(vector.X, vector.Y)
                        data.Line.Visible = true
                    else
                        data.Line.Visible = false
                    end
                else
                    data.Text.Visible = false
                    data.Line.Visible = false
                end
            else
                data.Text.Visible = false
                data.Line.Visible = false
            end
        end
    end
end)

local ToggleESP = Tab:CreateToggle({
   Name = "Players ESP",
   CurrentValue = false,
   Flag = "PlayerEspToggle",
   Callback = function(Value)
       _G.PlayerEspActive = Value
   end,
})

local ToggleTracers = Tab:CreateToggle({
   Name = "Show Tracers",
   CurrentValue = true,
   Flag = "PlayerTracersToggle",
   Callback = function(Value)
       _G.PlayerShowTracers = Value
   end,
})

local Slider = Tab:CreateSlider({
   Name = "ESP Distance",
   Range = {50, 2000},
   Increment = 25,
   Suffix = " Studs",
   CurrentValue = 50,
   Flag = "PlayerEspDistanceSlider", 
   Callback = function(Value)
       _G.PlayerEspDistance = Value
   end,
})


local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

_G.BerryEspActive = false
_G.BerryEspDistance = 50

local berryDrawings = {}

local function removeBerryESP(object)
    if berryDrawings[object] then
        if berryDrawings[object].Text then
            berryDrawings[object].Text.Visible = false
            berryDrawings[object].Text:Destroy()
        end
        berryDrawings[object] = nil
    end
end

local function checkAndCreateESP(child)
    if child.Name:lower() == "berry" then
        if child:IsA("Model") then
            local mainPart = child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart")
            if mainPart then 
                berryDrawings[mainPart] = {
                    Text = Drawing.new("Text"), 
                    Part = mainPart
                }
                local t = berryDrawings[mainPart].Text
                t.Visible = false; t.Size = 14; t.Center = true; t.Outline = true
                t.Color = Color3.fromRGB(0, 255, 120)
            end
        elseif child:IsA("BasePart") and not child.Parent:IsA("Model") then
            berryDrawings[child] = {
                Text = Drawing.new("Text"), 
                Part = child
            }
            local t = berryDrawings[child].Text
            t.Visible = false; t.Size = 14; t.Center = true; t.Outline = true
            t.Color = Color3.fromRGB(0, 255, 120)
        end
    end
end

for _, child in pairs(Workspace:GetDescendants()) do
    checkAndCreateESP(child)
end

Workspace.DescendantAdded:Connect(function(child)
    checkAndCreateESP(child)
end)

RunService.RenderStepped:Connect(function()
    if not _G.BerryEspActive then
        for _, data in pairs(berryDrawings) do 
            data.Text.Visible = false 
        end
        return
    end

    local localCharacter = game.Players.LocalPlayer.Character
    local localHrp = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")

    for object, data in pairs(berryDrawings) do
        if not object or not object:IsDescendantOf(Workspace) then
            removeBerryESP(object)
        elseif localHrp then
            local distance = (localHrp.Position - data.Part.Position).Magnitude
            
            if distance <= _G.BerryEspDistance then
                local vector, onScreen = Camera:WorldToViewportPoint(data.Part.Position)
                if onScreen then
                    data.Text.Position = Vector2.new(vector.X, vector.Y - 20)
                    data.Text.Text = string.format("🌿 Bush [%dм]", distance)
                    data.Text.Visible = true
                else
                    data.Text.Visible = false
                end
            else
                data.Text.Visible = false
            end
        else
            data.Text.Visible = false
        end
    end
end)

local Toggle = Tab:CreateToggle({
   Name = "Berry Bush ESP",
   CurrentValue = false,
   Flag = "BerryEspToggle",
   Callback = function(Value)
       _G.BerryEspActive = Value
   end,
 })

local Slider = Tab:CreateSlider({
   Name = "ESP Distance",
   Range = {50, 2000},
   Increment = 25,
   Suffix = " Studs",
   CurrentValue = 50,
   Flag = "BerryEspDistanceSlider", 
   Callback = function(Value)
       _G.BerryEspDistance = Value
   end,
})

local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

_G.CrateEspActive = false
_G.CrateEspDistance = 50

local crateDrawings = {}

local function removeCrateESP(object)
    if crateDrawings[object] then
        if crateDrawings[object].Text then
            crateDrawings[object].Text.Visible = false
            crateDrawings[object].Text:Destroy()
        end
        crateDrawings[object] = nil
    end
end

local function checkAndCreateCrateESP(child)
    if child.Name:lower() == "crate" then
        if child:IsA("Model") then
            local mainPart = child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart")
            if mainPart then 
                crateDrawings[mainPart] = {
                    Text = Drawing.new("Text"), 
                    Part = mainPart
                }
                local t = crateDrawings[mainPart].Text
                t.Visible = false; t.Size = 14; t.Center = true; t.Outline = true
                t.Color = Color3.fromRGB(255, 165, 0)
            end
        elseif child:IsA("BasePart") and not child.Parent:IsA("Model") then
            crateDrawings[child] = {
                Text = Drawing.new("Text"), 
                Part = child
            }
            local t = crateDrawings[child].Text
            t.Visible = false; t.Size = 14; t.Center = true; t.Outline = true
            t.Color = Color3.fromRGB(255, 165, 0)
        end
    end
end

for _, child in pairs(Workspace:GetDescendants()) do
    checkAndCreateCrateESP(child)
end

Workspace.DescendantAdded:Connect(function(child)
    checkAndCreateCrateESP(child)
end)

RunService.RenderStepped:Connect(function()
    if not _G.CrateEspActive then
        for _, data in pairs(crateDrawings) do 
            data.Text.Visible = false 
        end
        return
    end

    local localCharacter = game.Players.LocalPlayer.Character
    local localHrp = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")

    for object, data in pairs(crateDrawings) do
        if not object or not object:IsDescendantOf(Workspace) then
            removeCrateESP(object)
        elseif localHrp then
            local distance = (localHrp.Position - data.Part.Position).Magnitude
            
            if distance <= _G.CrateEspDistance then
                local vector, onScreen = Camera:WorldToViewportPoint(data.Part.Position)
                if onScreen then
                    data.Text.Position = Vector2.new(vector.X, vector.Y - 20)
                    data.Text.Text = string.format("📦 Crate [%dм]", distance)
                    data.Text.Visible = true
                else
                    data.Text.Visible = false
                end
            else
                data.Text.Visible = false
            end
        else
            data.Text.Visible = false
        end
    end
end)

local Toggle = Tab:CreateToggle({
   Name = "Crate ESP",
   CurrentValue = false,
   Flag = "CrateEspToggle",
   Callback = function(Value)
       _G.CrateEspActive = Value
   end,
})

local Slider = Tab:CreateSlider({
   Name = "Crate ESP Distance",
   Range = {50, 2000},
   Increment = 25,
   Suffix = " Studs",
   CurrentValue = 50,
   Flag = "CrateEspDistanceSlider", 
   Callback = function(Value)
       _G.CrateEspDistance = Value
   end,
})

local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

_G.LongHorseEspActive = false
_G.LongHorseEspDistance = 50

local longHorseDrawings = {}

local function removeLongHorseESP(object)
    if longHorseDrawings[object] then
        if longHorseDrawings[object].Text then
            longHorseDrawings[object].Text.Visible = false
            longHorseDrawings[object].Text:Destroy()
        end
        longHorseDrawings[object] = nil
    end
end

local function checkAndCreateLongHorseESP(child)
    if child.Name:lower() == "long_horse" then
        if child:IsA("Model") then
            local mainPart = child.PrimaryPart or child:FindFirstChild("HumanoidRootPart") or child:FindFirstChildWhichIsA("BasePart")
            if mainPart then 
                longHorseDrawings[mainPart] = {
                    Text = Drawing.new("Text"), 
                    Part = mainPart
                }
                local t = longHorseDrawings[mainPart].Text
                t.Visible = false; t.Size = 16; t.Center = true; t.Outline = true
                t.Color = Color3.fromRGB(255, 0, 0)
            end
        elseif child:IsA("BasePart") and not child.Parent:IsA("Model") then
            longHorseDrawings[child] = {
                Text = Drawing.new("Text"), 
                Part = child
            }
            local t = longHorseDrawings[child].Text
            t.Visible = false; t.Size = 16; t.Center = true; t.Outline = true
            t.Color = Color3.fromRGB(255, 0, 0)
        end
    end
end

for _, child in pairs(Workspace:GetDescendants()) do
    checkAndCreateLongHorseESP(child)
end

Workspace.DescendantAdded:Connect(function(child)
    checkAndCreateLongHorseESP(child)
end)

RunService.RenderStepped:Connect(function()
    if not _G.LongHorseEspActive then
        for _, data in pairs(longHorseDrawings) do 
            data.Text.Visible = false 
        end
        return
    end

    local localCharacter = game.Players.LocalPlayer.Character
    local localHrp = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")

    for object, data in pairs(longHorseDrawings) do
        if not object or not object:IsDescendantOf(Workspace) then
            removeLongHorseESP(object)
        elseif localHrp then
            local distance = (localHrp.Position - data.Part.Position).Magnitude
            
            if distance <= _G.LongHorseEspDistance then
                local vector, onScreen = Camera:WorldToViewportPoint(data.Part.Position)
                if onScreen then
                    data.Text.Position = Vector2.new(vector.X, vector.Y - 30)
                    data.Text.Text = string.format("⚠️ LONG HORSE [%dм]", distance)
                    data.Text.Visible = true
                else
                    data.Text.Visible = false
                end
            else
                data.Text.Visible = false
            end
        else
            data.Text.Visible = false
        end
    end
end)

local Toggle = Tab:CreateToggle({
   Name = "Long Horse ESP",
   CurrentValue = false,
   Flag = "LongHorseEspToggle",
   Callback = function(Value)
       _G.LongHorseEspActive = Value
   end,
})

local Slider = Tab:CreateSlider({
   Name = "Long Horse Distance",
   Range = {50, 2000},
   Increment = 25,
   Suffix = " Studs",
   CurrentValue = 50,
   Flag = "LongHorseEspDistanceSlider", 
   Callback = function(Value)
       _G.LongHorseEspDistance = Value
   end,
})

local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

_G.CartoonCatEspActive = false
_G.CartoonCatEspDistance = 50

local cartoonCatDrawings = {}

local function removeCartoonCatESP(object)
    if cartoonCatDrawings[object] then
        if cartoonCatDrawings[object].Text then
            cartoonCatDrawings[object].Text.Visible = false
            cartoonCatDrawings[object].Text:Destroy()
        end
        cartoonCatDrawings[object] = nil
    end
end

local function checkAndCreateCartoonCatESP(child)
    if child.Name:lower() == "real_cartoon_cat" then
        if child:IsA("Model") then
            local mainPart = child.PrimaryPart or child:FindFirstChild("HumanoidRootPart") or child:FindFirstChildWhichIsA("BasePart")
            if mainPart then 
                cartoonCatDrawings[mainPart] = {
                    Text = Drawing.new("Text"), 
                    Part = mainPart
                }
                local t = cartoonCatDrawings[mainPart].Text
                t.Visible = false; t.Size = 16; t.Center = true; t.Outline = true
                t.Color = Color3.fromRGB(255, 0, 0)
            end
        elseif child:IsA("BasePart") and not child.Parent:IsA("Model") then
            cartoonCatDrawings[child] = {
                Text = Drawing.new("Text"), 
                Part = child
            }
            local t = cartoonCatDrawings[child].Text
            t.Visible = false; t.Size = 16; t.Center = true; t.Outline = true
            t.Color = Color3.fromRGB(255, 0, 0)
        end
    end
end

for _, child in pairs(Workspace:GetDescendants()) do
    checkAndCreateCartoonCatESP(child)
end

Workspace.DescendantAdded:Connect(function(child)
    checkAndCreateCartoonCatESP(child)
end)

RunService.RenderStepped:Connect(function()
    if not _G.CartoonCatEspActive then
        for _, data in pairs(cartoonCatDrawings) do 
            data.Text.Visible = false 
        end
        return
    end

    local localCharacter = game.Players.LocalPlayer.Character
    local localHrp = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")

    for object, data in pairs(cartoonCatDrawings) do
        if not object or not object:IsDescendantOf(Workspace) then
            removeCartoonCatESP(object)
        elseif localHrp then
            local distance = (localHrp.Position - data.Part.Position).Magnitude
            
            if distance <= _G.CartoonCatEspDistance then
                local vector, onScreen = Camera:WorldToViewportPoint(data.Part.Position)
                if onScreen then
                    data.Text.Position = Vector2.new(vector.X, vector.Y - 30)
                    data.Text.Text = string.format("🚨 CARTOON CAT [%dм]", distance)
                    data.Text.Visible = true
                else
                    data.Text.Visible = false
                end
            else
                data.Text.Visible = false
            end
        else
            data.Text.Visible = false
        end
    end
end)

local Toggle = Tab:CreateToggle({
   Name = "Cartoon Cat ESP",
   CurrentValue = false,
   Flag = "CartoonCatEspToggle",
   Callback = function(Value)
       _G.CartoonCatEspActive = Value
   end,
})

local Slider = Tab:CreateSlider({
   Name = "Cartoon Cat Distance",
   Range = {50, 2000},
   Increment = 25,
   Suffix = " Studs",
   CurrentValue = 50,
   Flag = "CartoonCatEspDistanceSlider", 
   Callback = function(Value)
       _G.CartoonCatEspDistance = Value
   end,
})

local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

_G.RealSirenEspActive = false
_G.RealSirenEspDistance = 50

local realSirenDrawings = {}

local function removeRealSirenESP(object)
    if realSirenDrawings[object] then
        if realSirenDrawings[object].Text then
            realSirenDrawings[object].Text.Visible = false
            realSirenDrawings[object].Text:Destroy()
        end
        realSirenDrawings[object] = nil
    end
end

local function checkAndCreateRealSirenESP(child)
    if child.Name:lower() == "real_siren" then
        if child:IsA("Model") then
            local mainPart = child.PrimaryPart or child:FindFirstChild("HumanoidRootPart") or child:FindFirstChildWhichIsA("BasePart")
            if mainPart then 
                realSirenDrawings[mainPart] = {
                    Text = Drawing.new("Text"), 
                    Part = mainPart
                }
                local t = realSirenDrawings[mainPart].Text
                t.Visible = false; t.Size = 16; t.Center = true; t.Outline = true
                t.Color = Color3.fromRGB(255, 0, 0)
            end
        elseif child:IsA("BasePart") and not child.Parent:IsA("Model") then
            realSirenDrawings[child] = {
                Text = Drawing.new("Text"), 
                Part = child
            }
            local t = realSirenDrawings[child].Text
            t.Visible = false; t.Size = 16; t.Center = true; t.Outline = true
            t.Color = Color3.fromRGB(255, 0, 0)
        end
    end
end

for _, child in pairs(Workspace:GetDescendants()) do
    checkAndCreateRealSirenESP(child)
end

Workspace.DescendantAdded:Connect(function(child)
    checkAndCreateRealSirenESP(child)
end)

RunService.RenderStepped:Connect(function()
    if not _G.RealSirenEspActive then
        for _, data in pairs(realSirenDrawings) do 
            data.Text.Visible = false 
        end
        return
    end

    local localCharacter = game.Players.LocalPlayer.Character
    local localHrp = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")

    for object, data in pairs(realSirenDrawings) do
        if not object or not object:IsDescendantOf(Workspace) then
            removeRealSirenESP(object)
        elseif localHrp then
            local distance = (localHrp.Position - data.Part.Position).Magnitude
            
            if distance <= _G.RealSirenEspDistance then
                local vector, onScreen = Camera:WorldToViewportPoint(data.Part.Position)
                if onScreen then
                    data.Text.Position = Vector2.new(vector.X, vector.Y - 30)
                    data.Text.Text = string.format("🔊 SIREN HEAD [%dм]", distance)
                    data.Text.Visible = true
                else
                    data.Text.Visible = false
                end
            else
                data.Text.Visible = false
            end
        else
            data.Text.Visible = false
        end
    end
end)

local Toggle = Tab:CreateToggle({
   Name = "Real Siren ESP",
   CurrentValue = false,
   Flag = "RealSirenEspToggle",
   Callback = function(Value)
       _G.RealSirenEspActive = Value
   end,
})

local Slider = Tab:CreateSlider({
   Name = "Real Siren Distance",
   Range = {50, 2000},
   Increment = 25,
   Suffix = " Studs",
   CurrentValue = 50,
   Flag = "RealSirenEspDistanceSlider", 
   Callback = function(Value)
       _G.RealSirenEspDistance = Value
   end,
})

local Tab = Window:CreateTab("Destroy", 0)

local DestroyButton = Tab:CreateButton({
   Name = "Unload Script",
   Callback = function()
       _G.AllInfAmmoActive = false
       _G.NoDelayActive = false
       _G.InfRangeActive = false
       _G.NoRecoilAndSpread = false
       _G.NpcEspActive = false
       _G.BerryEspActive = false
       _G.CrateEspActive = false
       _G.LongHorseEspActive = false
       _G.CartoonCatEspActive = false
       _G.RealSirenEspActive = false
       _G.PlayerEspActive = false
       _G.PlayerShowTracers = false
       
       TargetSpeed = 16 
       TargetJump = 50  
       
       task.wait(0.1)
       
       local function clearTable(t)
           for _, data in pairs(t) do
               if type(data) == "table" then
                   if data.Text then data.Text:Destroy() end
                   if data.Line then data.Line:Destroy() end
               end
           end
       end
       
       if berryDrawings then clearTable(berryDrawings) end
       if crateDrawings then clearTable(crateDrawings) end
       if longHorseDrawings then clearTable(longHorseDrawings) end
       if cartoonCatDrawings then clearTable(cartoonCatDrawings) end
       if realSirenDrawings then clearTable(realSirenDrawings) end
       if playerDrawings then clearTable(playerDrawings) end
       
       Rayfield:Destroy()
   end,
})

