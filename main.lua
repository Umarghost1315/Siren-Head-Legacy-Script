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

local Tab = Window:CreateTab("Gun", 0)

local originalAmmo = {}

local originalAmmo = {}

local ToggleAmmo = Tab:CreateToggle({
   Name = "Inf Ammo",
   CurrentValue = false,
   Flag = "InfAmmoToggle",
   Callback = function(Value)
       _G.AllInfAmmoActive = Value
       
       if Value then
           task.spawn(function()
               while _G.AllInfAmmoActive do
                   local ActiveWeapon = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                   if ActiveWeapon then
                       for _, child in pairs(ActiveWeapon:GetDescendants()) do
                           if child:IsA("IntValue") or child:IsA("NumberValue") then
                               local name = child.Name:lower()
                               if name == "ammo" or name == "mag" or name == "mag_size" then
                                   if not originalAmmo[child] then
                                       originalAmmo[child] = child.Value
                                   end
                                   child.Value = 999
                               end
                           end
                       end
                   end
                   task.wait(0.01)
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
                    -- Формируем строку со здоровьем игрока
                    local hpText = string.format(" [HP: %d/%d]", math.floor(hum.Health), math.floor(hum.MaxHealth))
                    
                    data.Text.Position = Vector2.new(vector.X, vector.Y - 30)
                    data.Text.Text = string.format("👤 %s [%dм]%s", player.Name, distance, hpText)
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
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

_G.CartoonCatEspActive = false
_G.CartoonCatEspDistance = 1000

local catTexts = {}

RunService.RenderStepped:Connect(function()
    local localCharacter = LocalPlayer.Character
    local localHrp = localCharacter and (localCharacter:FindFirstChild("HumanoidRootPart") or localCharacter.PrimaryPart)

    if not _G.CartoonCatEspActive then
        for textObj, _ in pairs(catTexts) do textObj.Visible = false end
        return
    end

    local catIdx = 1
    local catTextArray = {}
    for t, _ in pairs(catTexts) do table.insert(catTextArray, t) end

    local scpsFolder = Workspace:FindFirstChild("scps")
    if scpsFolder then
        for _, child in pairs(scpsFolder:GetChildren()) do
            if child:IsA("Model") and child.Name:lower() == "real_cartoon_cat" then
                local part = child.PrimaryPart or child:FindFirstChild("HumanoidRootPart") or child:FindFirstChildWhichIsA("BasePart")
                local hum = child:FindFirstChildOfClass("Humanoid")
                
                if part and localHrp then
                    local distance = (localHrp.Position - part.Position).Magnitude
                    if distance <= _G.CartoonCatEspDistance then
                        local vector, onScreen = Camera:WorldToViewportPoint(part.Position)
                        if onScreen then
                            local textObj = catTextArray[catIdx]
                            if not textObj then
                                textObj = Drawing.new("Text")
                                textObj.Size = 16
                                textObj.Center = true
                                textObj.Outline = true
                                textObj.Color = Color3.fromRGB(255, 0, 0)
                                catTexts[textObj] = true
                            end
                            
                           local hpText = ""
                            if hum then
                                hpText = string.format(" [HP: %d/%d]", math.floor(hum.Health), math.floor(hum.MaxHealth))
                            end

                            textObj.Position = Vector2.new(vector.X, vector.Y - 30)
                            textObj.Text = string.format("🚨 CARTOON CAT [%dм]%s", distance, hpText)
                            textObj.Visible = true
                            catIdx = catIdx + 1
                        end
                    end
                end
            end
        end
    end

    for i = catIdx, #catTextArray do
        catTextArray[i].Visible = false
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
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

_G.RealSirenEspActive = false
_G.RealSirenEspDistance = 50

local sirenTexts = {}

RunService.RenderStepped:Connect(function()
    local localCharacter = LocalPlayer.Character
    local localHrp = localCharacter and (localCharacter:FindFirstChild("HumanoidRootPart") or localCharacter.PrimaryPart)

    if not _G.RealSirenEspActive then
        for textObj, _ in pairs(sirenTexts) do textObj.Visible = false end
        return
    end

    local sirenIdx = 1
    local sirenTextArray = {}
    for t, _ in pairs(sirenTexts) do table.insert(sirenTextArray, t) end

    local scpsFolder = Workspace:FindFirstChild("scps")
    if scpsFolder then
        for _, child in pairs(scpsFolder:GetChildren()) do
            if child:IsA("Model") and child.Name:lower() == "real_siren" then
                local part = child.PrimaryPart or child:FindFirstChild("HumanoidRootPart") or child:FindFirstChildWhichIsA("BasePart")
                local hum = child:FindFirstChildOfClass("Humanoid")
                
                if part and localHrp then
                    local distance = (localHrp.Position - part.Position).Magnitude
                    if distance <= _G.RealSirenEspDistance then
                        local vector, onScreen = Camera:WorldToViewportPoint(part.Position)
                        if onScreen then
                            local textObj = sirenTextArray[sirenIdx]
                            if not textObj then
                                textObj = Drawing.new("Text")
                                textObj.Size = 16
                                textObj.Center = true
                                textObj.Outline = true
                                textObj.Color = Color3.fromRGB(255, 0, 0)
                                sirenTexts[textObj] = true
                            end
                            
                            local hpText = ""
                            if hum then
                                hpText = string.format(" [HP: %d/%d]", math.floor(hum.Health), math.floor(hum.MaxHealth))
                            end

                            textObj.Position = Vector2.new(vector.X, vector.Y - 30)
                            textObj.Text = string.format("🔊 SIREN HEAD [%dм]%s", distance, hpText)
                            textObj.Visible = true
                            sirenIdx = sirenIdx + 1
                        end
                    end
                end
            end
        end
    end

    for i = sirenIdx, #sirenTextArray do
        sirenTextArray[i].Visible = false
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
   Suffix = "Studs",
   CurrentValue = 50,
   Flag = "RealSirenEspDistanceSlider", 
   Callback = function(Value)
       _G.RealSirenEspDistance = Value
   end,
})

local Tab = Window:CreateTab("AimBot", 0)

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

_G.SilentAimActive = false
_G.SilentAimFovEnabled = true
_G.SilentAimFovRadius = 100
_G.SilentAimKey = Enum.KeyCode.E
_G.SilentAimSmoothness = 0.5

local isAimKeyDown = false

local FovCircle = Drawing.new("Circle")
FovCircle.Thickness = 1.5
FovCircle.Color = Color3.fromRGB(255, 0, 80)
FovCircle.Filled = false
FovCircle.Transparency = 0.8
FovCircle.Visible = false

local function isVisibleThroughWalls(targetPart)
    local localCharacter = LocalPlayer.Character
    if not localCharacter then return false end
    
    local startPos = Camera.CFrame.Position
    local direction = targetPart.Position - startPos
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {localCharacter, targetPart.Parent}
    
    local raycastResult = Workspace:Raycast(startPos, direction, raycastParams)
    return not raycastResult
end

local function getClosestNPC()
    if not _G.SilentAimActive then return nil end

    local closestNPC = nil
    local shortestDistance = math.huge
    local scpsFolder = Workspace:FindFirstChild("scps")
    local mousePos = UserInputService:GetMouseLocation()
    
    if scpsFolder then
        for _, child in pairs(scpsFolder:GetChildren()) do
            if child:IsA("Model") then
                local hum = child:FindFirstChildOfClass("Humanoid")
                local targetPart = child:FindFirstChild("Head") or child:FindFirstChild("HumanoidRootPart") or child.PrimaryPart
                
                if targetPart and (not hum or hum.Health > 0) then
                    local vector, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    
                    if onScreen then
                        local screenDistance = (Vector2.new(vector.X, vector.Y) - mousePos).Magnitude
                        if screenDistance <= _G.SilentAimFovRadius and screenDistance < shortestDistance then
                            if isVisibleThroughWalls(targetPart) then
                                closestNPC = targetPart
                                shortestDistance = screenDistance
                            end
                        end
                    end
                end
            end
        end
    end
    return closestNPC
end

local function checkInput(input, state)
    local targetKey = _G.SilentAimKey
    if not targetKey then return end

    if typeof(targetKey) == "EnumItem" then
        if input.KeyCode == targetKey or input.UserInputType == targetKey then
            isAimKeyDown = state
        end
    elseif typeof(targetKey) == "string" then
        if input.KeyCode.Name == targetKey or input.UserInputType.Name == targetKey or tostring(targetKey):find(input.KeyCode.Name) then
            isAimKeyDown = state
        end
    end
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    checkInput(input, true)
end)

UserInputService.InputEnded:Connect(function(input)
    checkInput(input, false)
end)

RunService.RenderStepped:Connect(function()
    if _G.SilentAimActive and _G.SilentAimFovEnabled then
        FovCircle.Position = UserInputService:GetMouseLocation()
        FovCircle.Radius = _G.SilentAimFovRadius
        FovCircle.Visible = true
    else
        FovCircle.Visible = false
    end
    
    if _G.SilentAimActive and isAimKeyDown then
        local target = getClosestNPC()
        if target then
            local targetCFrame = CFrame.new(Camera.CFrame.Position, target.Position)
            if _G.SilentAimSmoothness >= 1 then
                Camera.CFrame = targetCFrame
            else
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, _G.SilentAimSmoothness)
            end
        end
    end
end)

local ToggleAim = Tab:CreateToggle({
   Name = "NPC Aimbot",
   CurrentValue = _G.SilentAimActive,
   Flag = "SilentAimToggle",
   Callback = function(Value)
       _G.SilentAimActive = Value
   end,
})

local ToggleFov = Tab:CreateToggle({
   Name = "Show FOV Circle",
   CurrentValue = _G.SilentAimFovEnabled,
   Flag = "SilentAimFovToggle",
   Callback = function(Value)
       _G.SilentAimFovEnabled = Value
   end,
})

local SliderFov = Tab:CreateSlider({
   Name = "FOV Size",
   Range = {30, 600},
   Increment = 10,
   Suffix = "px",
   CurrentValue = _G.SilentAimFovRadius,
   Flag = "SilentAimFovSlider", 
   Callback = function(Value)
       _G.SilentAimFovRadius = Value
   end,
})

local SliderSmooth = Tab:CreateSlider({
   Name = "Aimbot Smoothness",
   Range = {1, 10},
   Increment = 1,
   Suffix = "",
   CurrentValue = 10,
   Flag = "SilentAimSmoothSlider", 
   Callback = function(Value)
       _G.SilentAimSmoothness = Value / 10
   end,
})

local KeybindAim = Tab:CreateKeybind({
   Name = "Aimbot Keybind",
   CurrentKeybind = "E",
   HoldToTrigger = true,
   Flag = "SilentAimKeybind",
   Callback = function(Key)
       _G.SilentAimKey = Key
       isAimKeyDown = false
   end,
})

local Tab = Window:CreateTab("Destroy", 0)

local Button = Tab:CreateButton({
   Name = "Unload Script",
   Callback = function()
       _G.SilentAimActive = false
       _G.SilentAimFovEnabled = false
       _G.NpcAimbotActive = false
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
       
       if FovCircle then
           FovCircle.Visible = false
           FovCircle:Destroy()
       end
       
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
   end
})
