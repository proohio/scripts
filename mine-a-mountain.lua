if game.PlaceId ~= 125927821145949 then
    local lp = game:GetService("Players").LocalPlayer
    if lp then
        local gameName = "Game"
        local success, info = pcall(function()
            return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        end)
        if success and info then
            gameName = info
        else
            gameName = game.Name
        end
        lp:Kick("you been banned from " .. gameName)
    end
    return
end

if getgenv().MineAMountainScriptRunning then
    local oldRayfield = getgenv().Rayfield
    if oldRayfield then
        pcall(function()
            oldRayfield:Destroy()
        end)
    end
    getgenv().MineAMountainSessionID = nil
    getgenv().MineAMountainScriptRunning = false
    task.wait(0.1)
end
getgenv().MineAMountainScriptRunning = true
local sessionID = game:GetService("HttpService"):GenerateGUID(false)
getgenv().MineAMountainSessionID = sessionID

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
getgenv().Rayfield = Rayfield

local oldNotify = Rayfield.Notify
Rayfield.Notify = function(self, tbl)
    local title = tbl and tbl.Title or "Notification"
    local content = tbl and tbl.Content or ""
    local Remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
    local NotifyLocal = Remotes and Remotes:FindFirstChild("NotifyLocal")
    if NotifyLocal and NotifyLocal:IsA("BindableEvent") then
        pcall(function()
            NotifyLocal:Fire(tostring(title), tostring(content))
        end)
    else
        pcall(function()
            oldNotify(self, tbl)
        end)
    end
end

local Window = Rayfield:CreateWindow({
    Name = "Mine a Mountain",
    LoadingTitle = "Mine a Mountain",
    LoadingSubtitle = "by proohio",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = true,
    KeySettings = {
        Title = "Key Verification",
        Subtitle = "Mine a Mountain",
        Note = "Enter the access key",
        FileName = "MineAMountainKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"yigoisnoob"}
    }
})

local MainTab = Window:CreateTab("Automation")
local CrystalTab = Window:CreateTab("Goto Crystal")
local ExploitsTab = Window:CreateTab("Client Exploits")
local PlayerTab = Window:CreateTab("Player Hacks")

getgenv().MineAuraEnabled = false
getgenv().CrystalESPEnabled = false
getgenv().MineAuraRange = 15
getgenv().MineAuraDelay = 0.1
getgenv().OverrideWalkSpeed = nil
getgenv().OverrideJumpPower = nil
getgenv().InfiniteJumpEnabled = false
getgenv().AntiFallDamageEnabled = false
getgenv().InstantPromptsEnabled = false
getgenv().AutoBuyUpgradesEnabled = false
getgenv().AutoBuyShopEnabled = false
getgenv().FullbrightEnabled = false
getgenv().SuperHeadlightEnabled = false
getgenv().AutoSellEnabled = false

local lastNotifyTime = 0
local notifyCooldown = 5
local auraBox = nil
local Debris = game:GetService("Debris")
local crystalHighlights = {}
local isSelling = false

local function getCurrentWeight()
    local weight = 0
    local lp = game.Players.LocalPlayer
    local char = lp.Character
    if char then
        for _, v in ipairs(char:GetChildren()) do
            if v:IsA("Tool") and v:GetAttribute("Tier") ~= nil and v:GetAttribute("WeightKg") ~= nil then
                weight = weight + (v:GetAttribute("WeightKg") or 0)
            end
        end
    end
    local bp = lp:FindFirstChildOfClass("Backpack")
    if bp then
        for _, v in ipairs(bp:GetChildren()) do
            if v:IsA("Tool") and v:GetAttribute("Tier") ~= nil and v:GetAttribute("WeightKg") ~= nil then
                weight = weight + (v:GetAttribute("WeightKg") or 0)
            end
        end
    end
    return weight
end

local function getMaxWeight()
    local lp = game.Players.LocalPlayer
    local stats = lp:FindFirstChild("PlayerData") and lp.PlayerData:FindFirstChild("RealStats")
    local carryVal = stats and stats:FindFirstChild("CarryWeight")
    local baseCap = carryVal and carryVal.Value or 25
    
    local gamepasses = lp:FindFirstChild("GamepassesOwned")
    local gpVal = gamepasses and gamepasses:FindFirstChild("CarryKgPlus4")
    if gpVal and gpVal:IsA("BoolValue") and gpVal.Value then
        baseCap = baseCap * 4
    end
    
    local bonusVal = stats and stats:FindFirstChild("CarryWeightBonus")
    local bonus = bonusVal and bonusVal.Value or 0
    
    return baseCap + bonus
end

local function canDigAt(pos)
    local Things = workspace:FindFirstChild("Things")
    if Things then
        local noDigging = Things:FindFirstChild("NoDigging")
        if noDigging then
            if noDigging:IsA("BasePart") then
                local v1 = noDigging.CFrame:PointToObjectSpace(pos)
                local v2 = noDigging.Size * 0.5
                if math.abs(v1.X) <= v2.X and math.abs(v1.Y) <= v2.Y and math.abs(v1.Z) <= v2.Z then
                    return false
                end
            else
                for _, v in ipairs(noDigging:GetChildren()) do
                    if v:IsA("BasePart") then
                        local v1 = v.CFrame:PointToObjectSpace(pos)
                        local v2 = v.Size * 0.5
                        if math.abs(v1.X) <= v2.X and math.abs(v1.Y) <= v2.Y and math.abs(v1.Z) <= v2.Z then
                            return false
                        end
                    end
                end
            end
        end

        local zones = Things:FindFirstChild("Zones")
        if zones then
            for _, v in ipairs(zones:GetChildren()) do
                if v:IsA("BasePart") and v.Name == "NoDigZone" then
                    local v1 = v.CFrame:PointToObjectSpace(pos)
                    local v2 = v.Size * 0.5
                    if math.abs(v1.X) <= v2.X and math.abs(v1.Y) <= v2.Y and math.abs(v1.Z) <= v2.Z then
                        return false
                    end
                end
            end
        end
    end

    local mcX = workspace:GetAttribute("MountainCenterX")
    local mcZ = workspace:GetAttribute("MountainCenterZ")
    local mRad = workspace:GetAttribute("MountainRadius")
    local mBaseY = workspace:GetAttribute("MountainBaseY")
    local mPeakY = workspace:GetAttribute("MountainPeakY")

    if typeof(mcX) == "number" and typeof(mcZ) == "number" and typeof(mRad) == "number" and typeof(mBaseY) == "number" and typeof(mPeakY) == "number" then
        local dist = math.sqrt((pos.X - mcX)^2 + (pos.Z - mcZ)^2)
        return dist <= mRad + 60 and pos.Y >= mBaseY - 120 and pos.Y <= mPeakY + 120
    else
        local mZones = Things and Things:FindFirstChild("MountainZones")
        if mZones then
            for _, v in ipairs(mZones:GetChildren()) do
                if v:IsA("BasePart") and v.Name == "MountainZone" then
                    local v1 = v.CFrame:PointToObjectSpace(pos)
                    local v2 = v.Size * 0.5
                    if math.abs(v1.X) <= v2.X and math.abs(v1.Y) <= v2.Y and math.abs(v1.Z) <= v2.Z then
                        return true
                    end
                end
            end
        end
    end

    return false
end

getgenv().FreezeImmunityEnabled = false
local _freezeBlockedAttrs = {
    ["FreezeExposure"] = true,
    ["IsFreezing"] = true,
    ["AirDanger"] = true,
    ["FreezeThresholdStuds"] = true,
}

if hookmetamethod and getnamecallmethod and newcclosure and checkcaller then
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()

        if getgenv().AntiFallDamageEnabled then
            if (method == "FireServer" or method == "fireServer") and typeof(self) == "Instance" and self.Name == "FallDamage" then
                return
            end
        end

        if getgenv().FreezeImmunityEnabled and not checkcaller() then
            if method == "FireServer" and typeof(self) == "Instance" and self.Name == "FreezeDamage" then
                return nil
            end
            if method == "SetAttribute" then
                local args = {...}
                if typeof(self) == "Instance" and self == game:GetService("Players").LocalPlayer then
                    if args[1] and _freezeBlockedAttrs[args[1]] then
                        return nil
                    end
                end
            end
        end

        return oldNamecall(self, ...)
    end))
end

if hookmetamethod and newcclosure then
    local oldNewIndex
    oldNewIndex = hookmetamethod(game, "__newindex", newcclosure(function(self, idx, val)
        if self:IsA("Humanoid") and self.Parent == game.Players.LocalPlayer.Character then
            if idx == "WalkSpeed" then
                if getgenv().OverrideWalkSpeed then
                    return oldNewIndex(self, idx, getgenv().OverrideWalkSpeed)
                end
            elseif idx == "JumpPower" then
                if getgenv().OverrideJumpPower then
                    return oldNewIndex(self, idx, getgenv().OverrideJumpPower)
                end
            end
        end
        return oldNewIndex(self, idx, val)
    end))
end

local PathfindingService = game:GetService("PathfindingService")
local spawnedCrystalsList = {}
local spawnedPlatforms = {}

local function isCrystal(part)
    if part:GetAttribute("CrystalName") or part:GetAttribute("CrystalCode") then return true end
    local crystalsFolder = workspace:FindFirstChild("Things") and workspace.Things:FindFirstChild("Crystals")
    if crystalsFolder and part:IsDescendantOf(crystalsFolder) then return true end
    if part.Name == "CrystalPlatform" then return true end
    return false
end

local function getEquippedPickaxe(character)
    if not character then return nil end
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Tool") then
            local nameLower = string.lower(child.Name)
            if nameLower:find("pick") or nameLower:find("drill") or nameLower:find("shovel") then
                return child.Name
            end
        end
    end
    local player = game.Players.LocalPlayer
    local backpack = player and player:FindFirstChild("Backpack")
    if backpack then
        for _, child in ipairs(backpack:GetChildren()) do
            if child:IsA("Tool") then
                local nameLower = string.lower(child.Name)
                if nameLower:find("pick") or nameLower:find("drill") or nameLower:find("shovel") then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        pcall(function()
                            humanoid:EquipTool(child)
                        end)
                    else
                        child.Parent = character
                    end
                    return child.Name
                end
            end
        end
        for _, child in ipairs(backpack:GetChildren()) do
            if child:IsA("Tool") then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    pcall(function()
                        humanoid:EquipTool(child)
                    end)
                else
                    child.Parent = character
                end
                return child.Name
            end
        end
    end
    return nil
end

local function createVector(x, y, z)
    if typeof(x) == "Vector3" then
        y, z = x.Y, x.Z
        x = x.X
    end
    local customVector = getfenv().vector
    if customVector and typeof(customVector.create) == "function" then
        return customVector.create(x, y, z)
    else
        return Vector3.new(x, y, z)
    end
end

local function createAuraBox(character, range)
    return
end

local function getBlocksInAura(playerPos, range)
    local candidates = {}
    local Terrain = workspace:FindFirstChildOfClass("Terrain") or workspace.Terrain
    if not Terrain then return candidates end

    local queryRange = math.min(20, range)
    local minPos = Vector3.new(
        math.floor((playerPos.X - queryRange) / 4) * 4,
        math.floor((playerPos.Y - queryRange) / 4) * 4,
        math.floor((playerPos.Z - queryRange) / 4) * 4
    )
    local maxPos = Vector3.new(
        math.ceil((playerPos.X + queryRange) / 4) * 4,
        math.ceil((playerPos.Y + queryRange) / 4) * 4,
        math.ceil((playerPos.Z + queryRange) / 4) * 4
    )

    if minPos == maxPos then
        maxPos = maxPos + Vector3.new(4, 4, 4)
    end

    local ok, materials, occupancies = pcall(function()
        return Terrain:ReadVoxels(Region3.new(minPos, maxPos), 4)
    end)

    if ok and materials then
        local size = materials.Size
        for x = 1, size.X do
            for y = 1, size.Y do
                for z = 1, size.Z do
                    local material = materials[x][y][z]
                    local occupancy = occupancies[x][y][z]
                    if material ~= Enum.Material.Air and occupancy > 0.1 then
                        local voxelPos = minPos + Vector3.new(
                            (x - 0.5) * 4,
                            (y - 0.5) * 4,
                            (z - 0.5) * 4
                        )
                        local matName = material.Name:lower()
                        if not matName:find("bedrock") and not matName:find("water") then
                            if (voxelPos - playerPos).Magnitude <= queryRange and canDigAt(voxelPos) then
                                table.insert(candidates, voxelPos)
                            end
                        end
                    end
                end
            end
        end
    end
    
    return candidates
end

local function clickCenter()
    local vim = game:GetService("VirtualInputManager")
    local camera = workspace.CurrentCamera
    if vim and camera then
        local center = camera.ViewportSize / 2
        vim:SendMouseButtonEvent(center.X, center.Y, 0, true, game, 0)
        task.wait(0.02)
        vim:SendMouseButtonEvent(center.X, center.Y, 0, false, game, 0)
    end
end

local function simulateClick(character)
    local success = pcall(clickCenter)
    if not success then
        local tool = character:FindFirstChild("Tool") or character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
    end
end

local function highlightCrystal(crystal)
    if not crystal:IsA("BasePart") then return end
    if crystal:FindFirstChild("CrystalESPHighlight") then return end
    
    local r = crystal:GetAttribute("TierColorR") or 255
    local g = crystal:GetAttribute("TierColorG") or 255
    local b = crystal:GetAttribute("TierColorB") or 255
    local crystalColor = Color3.fromRGB(r, g, b)
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "CrystalESPHighlight"
    highlight.FillColor = crystalColor
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.Adornee = crystal
    highlight.Parent = crystal
    
    table.insert(crystalHighlights, highlight)
    
    local name = crystal:GetAttribute("CrystalName") or crystal.Name
    local tier = crystal:GetAttribute("TierName") or "Unknown"
    local value = crystal:GetAttribute("Value") or 0
    local weight = crystal:GetAttribute("WeightKg") or 0
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CrystalESPBillboard"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 150
    billboard.Adornee = crystal
    billboard.Parent = crystal
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = crystalColor
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 14
    label.Text = string.format("%s\nTier: %s | Val: %s | Wt: %skg", name, tier, tostring(value), tostring(weight))
    label.Parent = billboard
end

local function clearCrystalsESP()
    for _, highlight in ipairs(crystalHighlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    crystalHighlights = {}
    
    local folder = workspace:FindFirstChild("Things") and workspace.Things:FindFirstChild("Crystals")
    if folder then
        for _, child in ipairs(folder:GetDescendants()) do
            if child.Name == "CrystalESPHighlight" or child.Name == "CrystalESPBillboard" then
                child:Destroy()
            end
        end
    end
end

local function updateCrystalsESP()
    if not getgenv().CrystalESPEnabled then return end
    local folder = workspace:FindFirstChild("Things") and workspace.Things:FindFirstChild("Crystals")
    if folder then
        for _, child in ipairs(folder:GetChildren()) do
            highlightCrystal(child)
        end
    end
end

local function walkTo(targetPosition, noMine, forceWalk)
    local character = game.Players.LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not hrp then return end

    local RunService = game:GetService("RunService")
    local startMoveTime = tick()
    local arrived = false
    local stopped = false

    local function getGroundY(pos)
        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        local char = game.Players.LocalPlayer.Character
        local filterList = {}
        if char then table.insert(filterList, char) end
        if auraBox then table.insert(filterList, auraBox) end
        rayParams.FilterDescendantsInstances = filterList
        local downRay = workspace:Raycast(pos + Vector3.new(0, 10, 0), Vector3.new(0, -100, 0), rayParams)
        if downRay then
            return downRay.Position.Y + 3.5
        end
        return pos.Y
    end

    local function mineAlong(fromPos, toPos)
        local char = game.Players.LocalPlayer.Character
        if not char then return end
        local pickName = getEquippedPickaxe(char)
        if not pickName then return end
        local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
        local digRequest = remotes and remotes:FindFirstChild("DigRequest")
        if not digRequest then return end
        local Terrain = workspace:FindFirstChildOfClass("Terrain") or workspace.Terrain
        if not Terrain then return end

        local dir = (toPos - fromPos)
        if dir.Magnitude < 0.1 then return end
        local unit = dir.Unit

        local center = fromPos + unit * 5
        local range = 6
        local minPos = Vector3.new(
            math.floor((center.X - range) / 4) * 4,
            math.floor((center.Y - range) / 4) * 4,
            math.floor((center.Z - range) / 4) * 4
        )
        local maxPos = Vector3.new(
            math.ceil((center.X + range) / 4) * 4,
            math.ceil((center.Y + range) / 4) * 4,
            math.ceil((center.Z + range) / 4) * 4
        )
        if minPos == maxPos then
            maxPos = maxPos + Vector3.new(4, 4, 4)
        end

        local ok, materials, occupancies = pcall(function()
            return Terrain:ReadVoxels(Region3.new(minPos, maxPos), 4)
        end)

        if ok and materials then
            local size = materials.Size
            for x = 1, size.X do
                for y = 1, size.Y do
                    for z = 1, size.Z do
                        local material = materials[x][y][z]
                        local occupancy = occupancies[x][y][z]
                        if material ~= Enum.Material.Air and occupancy > 0.1 then
                            local voxelPos = minPos + Vector3.new(
                                (x - 0.5) * 4,
                                (y - 0.5) * 4,
                                (z - 0.5) * 4
                            )
                            local matName = material.Name:lower()
                            if not matName:find("bedrock") and not matName:find("water") and canDigAt(voxelPos) then
                                digRequest:FireServer(pickName, createVector(voxelPos.X, voxelPos.Y, voxelPos.Z))
                            end
                        end
                    end
                end
            end
        end
    end

    local MOVE_SPEED = 300
    local moveConn

    pcall(function()
        if hrp then hrp.Anchored = false end
    end)

    local lastPos = hrp.Position
    local lastPosCheck = tick()

    moveConn = RunService.RenderStepped:Connect(function(dt)
        if stopped then return end

        local char = game.Players.LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.CanCollide = false
            end
        end

        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero

        local direction = (targetPosition - root.Position)
        local dist = direction.Magnitude
        local horizontalDist = math.sqrt(direction.X^2 + direction.Z^2)

        if horizontalDist < 4 then
            arrived = true
            stopped = true
            return
        end

        if not (getgenv().OverrideWalkSpeed or forceWalk) or not getgenv().MineAMountainScriptRunning or getgenv().MineAMountainSessionID ~= sessionID then
            stopped = true
            return
        end

        if tick() - startMoveTime > 60 then
            stopped = true
            return
        end

        local unit = direction.Unit
        local moveDist = math.min(dist, MOVE_SPEED * dt)
        local nextPos = root.Position + unit * moveDist
        if not noMine then
            local groundY = getGroundY(nextPos)
            nextPos = Vector3.new(nextPos.X, groundY, nextPos.Z)
        end

        root.CFrame = CFrame.new(nextPos) * CFrame.Angles(0, math.atan2(-unit.X, -unit.Z), 0)
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end)

    while not stopped do
        task.wait(0.1)
        if not noMine then
            local root = (game.Players.LocalPlayer.Character or {}).HumanoidRootPart
            if root then
                mineAlong(root.Position, targetPosition)
            end
        end
    end

    if moveConn then moveConn:Disconnect() end

    task.wait(0.05)
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                p.CanCollide = true
            end
        end
    end
end

local function resetWalkSpeed()
    local char = game.Players.LocalPlayer.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16
    end
end

local function findSellPart()
    local map = workspace:FindFirstChild("Map")
    if not map then return nil end
    
    for _, desc in ipairs(map:GetDescendants()) do
        local isSellLabel = false
        
        if desc:IsA("TextLabel") or desc:IsA("TextBox") or desc:IsA("TextButton") then
            if desc.Text == "SELL" or desc.Text:upper():find("SELL") then
                isSellLabel = true
            end
        elseif desc:IsA("BillboardGui") or desc:IsA("SurfaceGui") then
            for _, sub in ipairs(desc:GetDescendants()) do
                if (sub:IsA("TextLabel") or sub:IsA("TextBox") or sub:IsA("TextButton")) and (sub.Text == "SELL" or sub.Text:upper():find("SELL")) then
                    isSellLabel = true
                    break
                end
            end
        elseif desc.Name == "SELL" or desc:GetAttribute("Text") == "SELL" then
            isSellLabel = true
        end
        
        if isSellLabel then
            local current = desc
            while current and not current:IsA("BasePart") do
                current = current.Parent
            end
            if current and current:IsA("BasePart") then
                return current
            end
        end
    end
    return nil
end

local function generateCrystalCode(crystal)
    local existing = crystal:GetAttribute("CrystalCode")
    if existing then return existing end
    
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local code = "Proohio_"
    for i = 1, 6 do
        local rand = math.random(1, #chars)
        code = code .. chars:sub(rand, rand)
    end
    crystal:SetAttribute("CrystalCode", code)
    return code
end

local Crystals5MDropdown = CrystalTab:CreateDropdown({
    Name = "Select 5M+ Crystal",
    Options = {},
    CurrentOption = "",
    MultipleOptions = false,
    Flag = "Crystals5MDropdown",
    Callback = function(Option)
    end
})

local spawned5MCrystalsList = {}

local function refresh5MCrystalDropdown()
    local options = {}
    local newSpawnedList = {}
    local folder = workspace:FindFirstChild("Things") and workspace.Things:FindFirstChild("Crystals")
    if folder then
        for _, crystal in ipairs(folder:GetChildren()) do
            if crystal:IsA("BasePart") then
                local value = crystal:GetAttribute("Value") or 0
                if value >= 5000000 then
                    local name = crystal:GetAttribute("CrystalName") or crystal.Name
                    local optionText = string.format("%s (Val: %s)", name, tostring(value))
                    table.insert(options, optionText)
                    newSpawnedList[optionText] = crystal
                end
            end
        end
    end
    spawned5MCrystalsList = newSpawnedList
    Crystals5MDropdown:Refresh(options, true)
end

local Goto5MCrystalButton = CrystalTab:CreateButton({
    Name = "Go to Selected 5M+ Crystal",
    Callback = function()
        local selectedText = Crystals5MDropdown.CurrentOption
        if typeof(selectedText) == "table" then
            selectedText = selectedText[1]
        end
        local crystal = spawned5MCrystalsList[selectedText]
        if crystal and crystal.Parent then
            task.spawn(function()
                local character = game.Players.LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    Rayfield:Notify({
                        Title = "Pathfinding",
                        Content = "Pathfinding to 5M+ crystal...",
                        Duration = 3,
                        Image = "navigation"
                    })
                    
                    walkTo(crystal.Position, true, true)
                    
                    if character then
                        for _, p in ipairs(character:GetDescendants()) do
                            if p:IsA("BasePart") then
                                p.CanCollide = false
                            end
                        end
                    end

                    local platform = Instance.new("Part")
                    platform.Name = "CrystalPlatform"
                    platform.Size = Vector3.new(12, 2, 12)
                    platform.Position = hrp.Position - Vector3.new(0, 3, 0)
                    platform.Anchored = true
                    platform.CanCollide = true
                    platform.Material = Enum.Material.SmoothPlastic
                    platform.Color = Color3.fromRGB(50, 50, 50)
                    platform.Transparency = 0.5
                    platform.Parent = workspace
                    table.insert(spawnedPlatforms, platform)
                    
                    hrp.CFrame = CFrame.new(platform.Position + Vector3.new(0, 2.5, 0))
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    
                    task.wait(0.2)
                    
                    if character then
                        for _, p in ipairs(character:GetDescendants()) do
                            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                                p.CanCollide = true
                            end
                        end
                    end

                    Rayfield:Notify({
                        Title = "Pathfinding",
                        Content = "Arrived at 5M+ crystal! Platform placed.",
                        Duration = 2,
                        Image = "check"
                    })
                end
            end)
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Selected 5M+ crystal no longer exists.",
                Duration = 3,
                Image = "alert-triangle"
            })
        end
    end
})

local MineAuraToggle = MainTab:CreateToggle({
    Name = "Mine Aura",
    CurrentValue = false,
    Flag = "MineAuraToggle",
    Callback = function(Value)
        getgenv().MineAuraEnabled = Value
        if not Value and auraBox then
            auraBox:Destroy()
            auraBox = nil
        end
        if Value then
            Rayfield:Notify({
                Title = "Mine Aura",
                Content = "Mine Aura enabled!",
                Duration = 2,
                Image = "check"
            })
        else
            Rayfield:Notify({
                Title = "Mine Aura",
                Content = "Mine Aura disabled.",
                Duration = 2,
                Image = "slash"
            })
        end
    end
})

local InstantPromptsToggle = MainTab:CreateToggle({
    Name = "Instant Prompts",
    CurrentValue = false,
    Flag = "InstantPromptsToggle",
    Callback = function(Value)
        getgenv().InstantPromptsEnabled = Value
        if not Value then
            
            for _, prompt in ipairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    local orig = prompt:GetAttribute("IMC_OrigHold")
                    if typeof(orig) == "number" then
                        prompt.HoldDuration = orig
                    end
                end
            end
        end
    end
})

local AutoBuyUpgradesToggle = MainTab:CreateToggle({
    Name = "Auto Buy Upgrades",
    CurrentValue = false,
    Flag = "AutoBuyUpgradesToggle",
    Callback = function(Value)
        getgenv().AutoBuyUpgradesEnabled = Value
    end
})

local AutoBuyShopToggle = MainTab:CreateToggle({
    Name = "Auto Buy Shop Items",
    CurrentValue = false,
    Flag = "AutoBuyShopToggle",
    Callback = function(Value)
        getgenv().AutoBuyShopEnabled = Value
    end
})

local AutoSellToggle = MainTab:CreateToggle({
    Name = "Auto Sell Full Bag",
    CurrentValue = false,
    Flag = "AutoSellToggle",
    Callback = function(Value)
        getgenv().AutoSellEnabled = Value
    end
})

local CrystalESPToggle = MainTab:CreateToggle({
    Name = "Crystal ESP",
    CurrentValue = false,
    Flag = "CrystalESPToggle",
    Callback = function(Value)
        getgenv().CrystalESPEnabled = Value
        if not Value then
            clearCrystalsESP()
        else
            updateCrystalsESP()
        end
    end
})

local SellButton = MainTab:CreateButton({
    Name = "Sell",
    Callback = function()
        local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 5)
        local goHome = remotes and remotes:WaitForChild("GoHome", 5)
        local sellRequest = remotes and remotes:WaitForChild("SellRequest", 5)
        
        if goHome then
            goHome:FireServer("sell")
            task.wait(0.3)
            if sellRequest then
                sellRequest:FireServer("all")
                Rayfield:Notify({
                    Title = "Sell",
                    Content = "Successfully sold items!",
                    Duration = 2,
                    Image = "check"
                })
            end
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Could not locate GoHome RemoteEvent.",
                Duration = 3,
                Image = "alert-triangle"
            })
        end
    end
})

local HomeButton = MainTab:CreateButton({
    Name = "Home",
    Callback = function()
        local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 5)
        local goHome = remotes and remotes:WaitForChild("GoHome", 5)
        if goHome then
            goHome:FireServer("home")
            Rayfield:Notify({
                Title = "Home",
                Content = "Teleported Home!",
                Duration = 2,
                Image = "check"
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Could not locate GoHome RemoteEvent.",
                Duration = 3,
                Image = "alert-triangle"
            })
        end
    end
})

local PlotButton = MainTab:CreateButton({
    Name = "Plot",
    Callback = function()
        local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 5)
        local goHome = remotes and remotes:WaitForChild("GoHome", 5)
        if goHome then
            goHome:FireServer("plot")
            Rayfield:Notify({
                Title = "Plot",
                Content = "Teleported to Plot!",
                Duration = 2,
                Image = "check"
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Could not locate GoHome RemoteEvent.",
                Duration = 3,
                Image = "alert-triangle"
            })
        end
    end
})

local RangeSlider = MainTab:CreateSlider({
    Name = "Aura Range",
    Range = {5, 50},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 15,
    Flag = "AuraRangeSlider",
    Callback = function(Value)
        getgenv().MineAuraRange = Value
        if auraBox and auraBox.Parent then
            auraBox.Size = Vector3.new(Value * 2, Value * 2, Value * 2)
        end
    end
})

local DelaySlider = MainTab:CreateSlider({
    Name = "Mining Delay",
    Range = {5, 100},
    Increment = 5,
    Suffix = " ms",
    CurrentValue = 10,
    Flag = "AuraDelaySlider",
    Callback = function(Value)
        getgenv().MineAuraDelay = Value / 100
    end
})

local CrystalDropdown = CrystalTab:CreateDropdown({
    Name = "Select Crystal",
    Options = {},
    CurrentOption = "",
    MultipleOptions = false,
    Flag = "SelectCrystalDropdown",
    Callback = function(Option)
    end
})

local function refreshCrystalDropdown()
    local options = {}
    local newSpawnedList = {}
    local folder = workspace:FindFirstChild("Things") and workspace.Things:FindFirstChild("Crystals")
    if folder then
        for _, crystal in ipairs(folder:GetChildren()) do
            if crystal:IsA("BasePart") then
                local name = crystal:GetAttribute("CrystalName") or crystal.Name
                local value = crystal:GetAttribute("Value") or 0
                local code = generateCrystalCode(crystal)
                local optionText = string.format("%s (Val: %s)", name, tostring(value))
                table.insert(options, optionText)
                newSpawnedList[optionText] = crystal
            end
        end
    end
    spawnedCrystalsList = newSpawnedList
    CrystalDropdown:Refresh(options, true)
end

local GotoCrystalButton = CrystalTab:CreateButton({
    Name = "Go to Selected Crystal",
    Callback = function()
        local selectedText = CrystalDropdown.CurrentOption
        if typeof(selectedText) == "table" then
            selectedText = selectedText[1]
        end
        local crystal = spawnedCrystalsList[selectedText]
        if crystal and crystal.Parent then
            task.spawn(function()
                local char = game.Players.LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    Rayfield:Notify({
                        Title = "Pathfinding",
                        Content = "Pathfinding to crystal...",
                        Duration = 3,
                        Image = "navigation"
                    })
                    
                    walkTo(crystal.Position, true, true)
                    
                    if char then
                        for _, p in ipairs(char:GetDescendants()) do
                            if p:IsA("BasePart") then
                                p.CanCollide = false
                            end
                        end
                    end

                    local platform = Instance.new("Part")
                    platform.Name = "CrystalPlatform"
                    platform.Size = Vector3.new(12, 2, 12)
                    platform.Position = hrp.Position - Vector3.new(0, 3, 0)
                    platform.Anchored = true
                    platform.CanCollide = true
                    platform.Material = Enum.Material.SmoothPlastic
                    platform.Color = Color3.fromRGB(50, 50, 50)
                    platform.Transparency = 0.5
                    platform.Parent = workspace
                    table.insert(spawnedPlatforms, platform)
                    
                    hrp.CFrame = CFrame.new(platform.Position + Vector3.new(0, 2.5, 0))
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    
                    task.wait(0.2)
                    
                    if char then
                        for _, p in ipairs(char:GetDescendants()) do
                            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                                p.CanCollide = true
                            end
                        end
                    end

                    Rayfield:Notify({
                        Title = "Pathfinding",
                        Content = "Arrived at crystal! Platform placed.",
                        Duration = 2,
                        Image = "check"
                    })
                end
            end)
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Selected crystal no longer exists.",
                Duration = 3,
                Image = "alert-triangle"
            })
        end
    end
})

local CrystalInput = CrystalTab:CreateInput({
    Name = "Enter Crystal Code",
    PlaceholderText = "Proohio_xxxxxx",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
    end
})

local GotoCodeButton = CrystalTab:CreateButton({
    Name = "Go to Entered Code",
    Callback = function()
        local targetCode = CrystalInput.CurrentValue
        if not targetCode or targetCode == "" then
            Rayfield:Notify({
                Title = "Error",
                Content = "Please enter a valid crystal code.",
                Duration = 3,
                Image = "alert-triangle"
            })
            return
        end
        
        local targetCrystal = nil
        local folder = workspace:FindFirstChild("Things") and workspace.Things:FindFirstChild("Crystals")
        if folder then
            for _, crystal in ipairs(folder:GetChildren()) do
                if crystal:IsA("BasePart") and crystal:GetAttribute("CrystalCode") == targetCode then
                    targetCrystal = crystal
                    break
                end
            end
        end
        
        if targetCrystal and targetCrystal.Parent then
            task.spawn(function()
                local char = game.Players.LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    Rayfield:Notify({
                        Title = "Pathfinding",
                        Content = "Pathfinding to crystal code " .. targetCode .. "...",
                        Duration = 3,
                        Image = "navigation"
                    })
                    
                    walkTo(targetCrystal.Position, true, true)
                    
                    local platform = Instance.new("Part")
                    platform.Name = "CrystalPlatform"
                    platform.Size = Vector3.new(12, 2, 12)
                    platform.Position = hrp.Position - Vector3.new(0, 3, 0)
                    platform.Anchored = true
                    platform.CanCollide = true
                    platform.Material = Enum.Material.SmoothPlastic
                    platform.Color = Color3.fromRGB(50, 50, 50)
                    platform.Transparency = 0.5
                    platform.Parent = workspace
                    table.insert(spawnedPlatforms, platform)
                    
                    hrp.CFrame = CFrame.new(platform.Position + Vector3.new(0, 2.5, 0))
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    
                    Rayfield:Notify({
                        Title = "Pathfinding",
                        Content = "Arrived at crystal! Platform placed.",
                        Duration = 2,
                        Image = "check"
                    })
                end
            end)
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Crystal with code " .. targetCode .. " is not spawned.",
                Duration = 3,
                Image = "alert-triangle"
            })
        end
    end
})

local RemovePartsButton = CrystalTab:CreateButton({
    Name = "Remove Parts",
    Callback = function()
        local count = 0
        for _, platform in ipairs(spawnedPlatforms) do
            if platform and platform.Parent then
                platform:Destroy()
                count = count + 1
            end
        end
        spawnedPlatforms = {}
        Rayfield:Notify({
            Title = "Remove Parts",
            Content = "Removed " .. count .. " platform(s).",
            Duration = 2,
            Image = "check"
        })
    end
})

local function refreshCaveZonesDropdown()
    local caveOptions = {}
    local zonesFolder = workspace:FindFirstChild("CaveZones")
    if zonesFolder then
        for _, child in ipairs(zonesFolder:GetChildren()) do
            if child:IsA("BasePart") then
                table.insert(caveOptions, child.Name)
            end
        end
    end
    table.sort(caveOptions, function(a, b)
        local numA = tonumber(a:match("%d+")) or 0
        local numB = tonumber(b:match("%d+")) or 0
        return numA < numB
    end)
    if ZoneDropdown then
        ZoneDropdown:Refresh(caveOptions, true)
    end
    return caveOptions
end

local ZoneDropdown
ZoneDropdown = CrystalTab:CreateDropdown({
    Name = "Teleport to Cave Zone",
    Options = refreshCaveZonesDropdown(),
    CurrentValue = "",
    MultipleOptions = false,
    Flag = "ZoneDropdown",
    Callback = function(Option)
        local zoneName = typeof(Option) == "table" and (Option[1] or Option) or Option
        local zonesFolder = workspace:FindFirstChild("CaveZones")
        local zonePart = zonesFolder and zonesFolder:FindFirstChild(zoneName)
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if zonePart and hrp then
            task.spawn(function()
                walkTo(zonePart.Position, true, true)
            end)
            Rayfield:Notify({
                Title = "Teleport",
                Content = "Teleported to " .. tostring(zoneName) .. "!",
                Duration = 2,
                Image = "navigation"
            })
        end
    end
})

local AntiFallToggle = ExploitsTab:CreateToggle({
    Name = "Anti-Fall Damage (Hook)",
    CurrentValue = false,
    Flag = "AntiFallToggle",
    Callback = function(Value)
        getgenv().AntiFallDamageEnabled = Value
        Rayfield:Notify({
            Title = "Anti-Fall Damage",
            Content = Value and "Anti-Fall Damage active (Hooked)!" or "Anti-Fall Damage disabled.",
            Duration = 2,
            Image = Value and "shield" or "shield-off"
        })
    end
})

local FullbrightToggle = ExploitsTab:CreateToggle({
    Name = "Fullbright (Lighting Bypass)",
    CurrentValue = false,
    Flag = "FullbrightToggle",
    Callback = function(Value)
        getgenv().FullbrightEnabled = Value
        if Value then
            task.spawn(function()
                while getgenv().FullbrightEnabled and getgenv().MineAMountainScriptRunning do
                    pcall(function()
                        game:GetService("Lighting").Brightness = 2
                        game:GetService("Lighting").ClockTime = 14
                        game:GetService("Lighting").FogEnd = 999999
                        game:GetService("Lighting").GlobalShadows = false
                    end)
                    task.wait(1)
                end
            end)
        else
            pcall(function()
                game:GetService("Lighting").Brightness = 1
                game:GetService("Lighting").GlobalShadows = true
            end)
        end
    end
})

local SuperHeadlightToggle = ExploitsTab:CreateToggle({
    Name = "Super Flashlight (Boost Attributes)",
    CurrentValue = false,
    Flag = "SuperHeadlightToggle",
    Callback = function(Value)
        getgenv().SuperHeadlightEnabled = Value
        local lp = game:GetService("Players").LocalPlayer
        if Value then
            task.spawn(function()
                while getgenv().SuperHeadlightEnabled and getgenv().MineAMountainScriptRunning do
                    pcall(function()
                        lp:SetAttribute("HeadlampBrightnessScale", 15)
                        lp:SetAttribute("HeadlampRangeScale", 15)
                        lp:SetAttribute("FreezeExposure", 0)
                    end)
                    task.wait(1)
                end
            end)
        else
            pcall(function()
                lp:SetAttribute("HeadlampBrightnessScale", 1)
                lp:SetAttribute("HeadlampRangeScale", 1)
            end)
        end
    end
})

local AntiAFKButton = ExploitsTab:CreateButton({
    Name = "Anti-AFK (Permanent)",
    Callback = function()
        pcall(function()
            local lp = game:GetService("Players").LocalPlayer
            local count = 0
            for _, conn in ipairs(getconnections(lp.Idled)) do
                conn:Disable()
                count = count + 1
            end
            Rayfield:Notify({
                Title = "Anti-AFK",
                Content = "Disabled " .. count .. " idle connection(s). You will never be kicked!",
                Duration = 3,
                Image = "shield"
            })
        end)
    end
})

getgenv().MemoryConfigEnabled = false
getgenv()._origToolSettings = {}

local _cachedToolConfigTables = nil

local function getToolConfigTables()
    if _cachedToolConfigTables then
        return _cachedToolConfigTables
    end
    
    local found = {}
    pcall(function()
        local rep = game:GetService("ReplicatedStorage")
        local modules = rep:FindFirstChild("Modules")
        local tools = modules and modules:FindFirstChild("Tools")
        local toolConfig = tools and tools:FindFirstChild("ToolConfig")
        if toolConfig and toolConfig:IsA("ModuleScript") then
            local tbl = require(toolConfig)
            if type(tbl) == "table" and tbl.Tools then
                table.insert(found, tbl)
            end
        end
    end)
    local getgcFunc = getfenv().getgc or getgc
    if getgcFunc then
        pcall(function()
            for _, v in pairs(getgcFunc(true)) do
                if type(v) == "table" and rawget(v, "Tools") and type(rawget(v, "Tools")) == "table" then
                    local tools = rawget(v, "Tools")
                    if tools.Pickaxe and type(tools.Pickaxe) == "table" and tools.Pickaxe.digRadius then
                        table.insert(found, v)
                    end
                end
            end
        end)
    end
    local getmodulesFunc = getfenv().getloadedmodules or getloadedmodules
    if getmodulesFunc then
        pcall(function()
            for _, mod in pairs(getmodulesFunc()) do
                if mod.Name == "ToolConfig" then
                    local tbl = require(mod)
                    if type(tbl) == "table" and tbl.Tools then
                        table.insert(found, tbl)
                    end
                end
            end
        end)
    end
    if #found > 0 then
        _cachedToolConfigTables = found
    end
    return found
end

local MemoryConfigToggle = ExploitsTab:CreateToggle({
    Name = "Faster Pickaxe & Range (RAM Edit)",
    CurrentValue = false,
    Flag = "MemoryConfigToggle",
    Callback = function(Value)
        getgenv().MemoryConfigEnabled = Value
        pcall(function()
            local tbls = getToolConfigTables()
            for _, tbl in ipairs(tbls) do
                if tbl.Tools then
                    for toolName, toolSettings in pairs(tbl.Tools) do
                        if Value then
                            if not getgenv()._origToolSettings[toolName] then
                                getgenv()._origToolSettings[toolName] = {
                                    digRadius = toolSettings.digRadius,
                                    maxReach = toolSettings.maxReach,
                                    cooldown = toolSettings.cooldown
                                }
                            end
                            toolSettings.digRadius = 15
                            toolSettings.maxReach = 80
                            toolSettings.cooldown = 0.01
                        else
                            local orig = getgenv()._origToolSettings[toolName]
                            if orig then
                                toolSettings.digRadius = orig.digRadius
                                toolSettings.maxReach = orig.maxReach
                                toolSettings.cooldown = orig.cooldown
                            end
                        end
                    end
                end
            end
            Rayfield:Notify({
                Title = "Memory Config",
                Content = Value and "RAM edited: digRadius=15, reach=80, cooldown=0.01!" or "Tool settings restored to default.",
                Duration = 3,
                Image = Value and "sliders" or "rotate-ccw"
            })
        end)
    end
})

task.spawn(function()
    while getgenv().MineAMountainScriptRunning do
        if getgenv().MemoryConfigEnabled then
            pcall(function()
                local tbls = getToolConfigTables()
                for _, tbl in ipairs(tbls) do
                    if tbl.Tools then
                        for toolName, toolSettings in pairs(tbl.Tools) do
                            toolSettings.digRadius = 15
                            toolSettings.maxReach = 80
                            toolSettings.cooldown = 0.01
                        end
                    end
                end
            end)
        end
        task.wait(1)
    end
end)

local FreezeImmunityToggle = ExploitsTab:CreateToggle({
    Name = "Freeze & Altitude Immunity (Hook)",
    CurrentValue = false,
    Flag = "FreezeImmunityToggle",
    Callback = function(Value)
        getgenv().FreezeImmunityEnabled = Value

        if Value and not getgenv()._freezeAirLoop then
            getgenv()._freezeAirLoop = true
            task.spawn(function()
                while getgenv().MineAMountainScriptRunning do
                    if getgenv().FreezeImmunityEnabled then
                        pcall(function()
                            local lp = game:GetService("Players").LocalPlayer
                            local pd = lp:FindFirstChild("PlayerData")
                            local rs = pd and pd:FindFirstChild("RealStats")
                            local currentAir = rs and rs:FindFirstChild("CurrentAir")
                            local airCap = rs and rs:FindFirstChild("AirCapacity")
                            if currentAir and airCap then
                                currentAir.Value = airCap.Value
                            end
                            lp:SetAttribute("FreezeExposure", 0)
                            lp:SetAttribute("IsFreezing", false)
                            lp:SetAttribute("AirDanger", 0)
                        end)
                    end
                    task.wait(0.5)
                end
            end)
        end

        Rayfield:Notify({
            Title = "Freeze Immunity",
            Content = Value and "You are now immune to freezing & altitude damage!" or "Freeze immunity disabled.",
            Duration = 2,
            Image = Value and "snowflake" or "thermometer"
        })
    end
})

local WalkSpeedSlider = PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 250},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        getgenv().OverrideWalkSpeed = Value
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = Value
            end
        end)
    end
})

local JumpPowerSlider = PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300},
    Increment = 1,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        getgenv().OverrideJumpPower = Value
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.UseJumpPower = true
                hum.JumpPower = Value
            end
        end)
    end
})

local InfJumpToggle = PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJumpToggle",
    Callback = function(Value)
        getgenv().InfiniteJumpEnabled = Value
    end
})

task.spawn(function()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local wasEnabled = false
    
    while getgenv().MineAMountainScriptRunning and getgenv().MineAMountainSessionID == sessionID do
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            
            if getgenv().OverrideWalkSpeed then
                if humanoid.WalkSpeed ~= getgenv().OverrideWalkSpeed then
                    humanoid.WalkSpeed = getgenv().OverrideWalkSpeed
                end
            else
                if wasEnabled then
                    wasEnabled = false
                    resetWalkSpeed()
                end
            end

            if getgenv().OverrideJumpPower then
                humanoid.UseJumpPower = true
                if humanoid.JumpPower ~= getgenv().OverrideJumpPower then
                    humanoid.JumpPower = getgenv().OverrideJumpPower
                end
            end

            humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            if not getgenv().AntiFallDamageEnabled then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
            end
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    local coreGui = game:GetService("CoreGui")
    local playerGui = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
    
    while getgenv().MineAMountainScriptRunning and getgenv().MineAMountainSessionID == sessionID do
        local screenGui = coreGui:FindFirstChild("Rayfield") or (playerGui and playerGui:FindFirstChild("Rayfield"))
        if not screenGui then
            getgenv().MineAMountainScriptRunning = false
            getgenv().MineAuraEnabled = false
            getgenv().CrystalESPEnabled = false
            resetWalkSpeed()
            clearCrystalsESP()
            if auraBox then
                auraBox:Destroy()
                auraBox = nil
            end
            break
        end
        task.wait(1)
    end
end)

task.spawn(function()
    local things = workspace:WaitForChild("Things", 10)
    local crystals = things and things:WaitForChild("Crystals", 10)
    
    local refreshDropdownDebounce = false
    local function queueDropdownRefresh()
        if refreshDropdownDebounce then return end
        refreshDropdownDebounce = true
        task.delay(0.8, function()
            refreshDropdownDebounce = false
            if getgenv().MineAMountainSessionID == sessionID then
                pcall(refreshCrystalDropdown)
                pcall(refresh5MCrystalDropdown)
            end
        end)
    end

    local refreshZonesDebounce = false
    local function queueZonesRefresh()
        if refreshZonesDebounce then return end
        refreshZonesDebounce = true
        task.delay(1.0, function()
            refreshZonesDebounce = false
            if getgenv().MineAMountainSessionID == sessionID then
                pcall(refreshCaveZonesDropdown)
            end
        end)
    end

    if crystals then
        crystals.ChildAdded:Connect(function(child)
            if getgenv().MineAMountainSessionID == sessionID then
                queueDropdownRefresh()
                if getgenv().CrystalESPEnabled then
                    task.spawn(function()
                        task.wait(0.1)
                        highlightCrystal(child)
                    end)
                end
            end
        end)
        crystals.ChildRemoved:Connect(function(child)
            if getgenv().MineAMountainSessionID == sessionID then
                queueDropdownRefresh()
            end
        end)
    end
    
    local zonesFolder = workspace:WaitForChild("CaveZones", 10)
    if zonesFolder then
        zonesFolder.ChildAdded:Connect(function(child)
            if getgenv().MineAMountainSessionID == sessionID then
                queueZonesRefresh()
            end
        end)
        zonesFolder.ChildRemoved:Connect(function(child)
            if getgenv().MineAMountainSessionID == sessionID then
                queueZonesRefresh()
            end
        end)
    end
end)

task.spawn(function()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local localPlayer = Players.LocalPlayer
    
    local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
    local digRequest = remotes and remotes:WaitForChild("DigRequest", 5)
    
    if not digRequest then
        Rayfield:Notify({
            Title = "Error",
            Content = "Could not locate ReplicatedStorage Remotes/DigRequest. Script might be outdated.",
            Duration = 5,
            Image = "alert-triangle"
        })
        getgenv().MineAMountainScriptRunning = false
        return
    end

    local lastMinePos = nil
    local minePosSameCount = 0

    task.spawn(function()
        while getgenv().MineAMountainScriptRunning and getgenv().MineAMountainSessionID == sessionID do
            if getgenv().CrystalESPEnabled then
                pcall(updateCrystalsESP)
            end
            task.wait(2)
        end
    end)

    while getgenv().MineAMountainScriptRunning and getgenv().MineAMountainSessionID == sessionID do

        if getgenv().MineAuraEnabled and not isSelling then
            local character = localPlayer.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            
            if rootPart then
                if not auraBox or auraBox.Parent ~= character then
                    createAuraBox(character, getgenv().MineAuraRange)
                end
                
                local pickName = getEquippedPickaxe(character)
                
                if pickName then
                    local blocks = getBlocksInAura(rootPart.Position, getgenv().MineAuraRange)
                    
                    if #blocks > 0 then
                        local currentPos = blocks[1]
                        if lastMinePos and (currentPos - lastMinePos).Magnitude < 0.5 then
                            minePosSameCount = minePosSameCount + 1
                        else
                            minePosSameCount = 0
                        end
                        lastMinePos = currentPos
                        
                        for _, pos in ipairs(blocks) do
                            local args = {
                                pickName,
                                createVector(pos.X, pos.Y, pos.Z)
                            }
                            digRequest:FireServer(unpack(args))
                        end
                    else
                        simulateClick(character)
                        minePosSameCount = 0
                        lastMinePos = nil
                    end
                else
                    minePosSameCount = 0
                    lastMinePos = nil
                    local currentTime = os.time()
                    if (currentTime - lastNotifyTime) >= notifyCooldown then
                        lastNotifyTime = currentTime
                        warn("pls equip your pickaxe")
                        Rayfield:Notify({
                            Title = "Equip Pickaxe",
                            Content = "pls equip your pickaxe",
                            Duration = 3,
                            Image = "alert-circle"
                        })
                    end
                    task.wait(1.5)
                end
            end
        else
            minePosSameCount = 0
            lastMinePos = nil
            if auraBox then
                auraBox:Destroy()
                auraBox = nil
            end
        end
        task.wait(getgenv().MineAuraDelay)
    end
end)

task.spawn(function()
    while getgenv().MineAMountainScriptRunning and getgenv().MineAMountainSessionID == sessionID do
        if getgenv().InstantPromptsEnabled then
            for _, prompt in ipairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    if typeof((prompt:GetAttribute("IMC_OrigHold"))) ~= "number" then
                        prompt:SetAttribute("IMC_OrigHold", prompt.HoldDuration)
                    end
                    prompt.HoldDuration = 0
                end
            end
        end
        task.wait(1)
    end
end)

task.spawn(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
    if not Remotes then return end

    local Notify = Remotes:WaitForChild("Notify", 5)
    local NotifyLocal = Remotes:WaitForChild("NotifyLocal", 5)

    local function handleNotification(kind, message)
        if not getgenv().MineAMountainScriptRunning or getgenv().MineAMountainSessionID ~= sessionID then return end
        
        local msgLower = string.lower(tostring(message))
        
        if string.find(msgLower, "too far") or string.find(msgLower, "only dig") then
            warn("[Notification Interceptor] Detected stuck warning: " .. tostring(message))
        end
        
        if string.find(msgLower, "full") or string.find(msgLower, "capacity") then
            warn("[Notification Interceptor] Detected full backpack! Auto-selling...")
            task.spawn(function()
                local goHome = Remotes:FindFirstChild("GoHome")
                local sellRequest = Remotes:FindFirstChild("SellRequest")
                if goHome and sellRequest then
                    goHome:FireServer("sell")
                    task.wait(0.5)
                    sellRequest:FireServer("all")
                    task.wait(0.5)
                    goHome:FireServer("plot")
                end
            end)
        end
    end

    if Notify and Notify:IsA("RemoteEvent") then
        Notify.OnClientEvent:Connect(function(p1, p2)
            if type(p1) == "string" and type(p2) == "string" then
                handleNotification(p1, p2)
            end
        end)
    end

    if NotifyLocal and NotifyLocal:IsA("BindableEvent") then
        NotifyLocal.Event:Connect(function(p1, p2)
            if type(p1) == "string" and type(p2) == "string" then
                handleNotification(p1, p2)
            end
        end)
    end
end)

task.spawn(function()
    local UserInputService = game:GetService("UserInputService")
    UserInputService.JumpRequest:Connect(function()
        if getgenv().InfiniteJumpEnabled and getgenv().MineAMountainScriptRunning then
            local char = game.Players.LocalPlayer.Character
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end)

task.spawn(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
    if not Remotes then return end
    
    local ReviveShow = Remotes:WaitForChild("ReviveShow", 5)
    local ReviveBase = Remotes:FindFirstChild("ReviveBase")
    
    if ReviveShow and ReviveBase then
        ReviveShow.OnClientEvent:Connect(function()
            if getgenv().MineAMountainScriptRunning and getgenv().MineAMountainSessionID == sessionID then
                
                ReviveBase:FireServer()
                
                local lp = game:GetService("Players").LocalPlayer
                local pgui = lp and lp:FindFirstChildOfClass("PlayerGui")
                local reviveGui = pgui and pgui:FindFirstChild("Revive")
                local frame = reviveGui and reviveGui:FindFirstChild("Frame")
                if frame then
                    frame.Visible = false
                end
            end
        end)
    end
end)

task.spawn(function()
    while getgenv().MineAMountainScriptRunning and getgenv().MineAMountainSessionID == sessionID do
        if getgenv().AutoBuyUpgradesEnabled then
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            local upgradeBuy = remotes and remotes:FindFirstChild("UpgradeBuy")
            if upgradeBuy then
                
                upgradeBuy:FireServer("Weight", 1)
                task.wait(0.2)
                upgradeBuy:FireServer("Weight", 2)
                task.wait(0.2)
                upgradeBuy:FireServer("Weight", 3)
                task.wait(0.2)
                
                upgradeBuy:FireServer("Air", 1)
                task.wait(0.2)
                upgradeBuy:FireServer("Air", 2)
                task.wait(0.2)
                upgradeBuy:FireServer("Air", 3)
            end
        end
        task.wait(5)
    end
end)

task.spawn(function()
    while getgenv().MineAMountainScriptRunning and getgenv().MineAMountainSessionID == sessionID do
        if getgenv().AutoBuyShopEnabled then
            pcall(function()
                local lp = game:GetService("Players").LocalPlayer
                local playerData = lp:FindFirstChild("PlayerData")
                local owned = playerData and playerData:FindFirstChild("Owned")
                local stats = playerData and playerData:FindFirstChild("RealStats")
                local cashVal = stats and stats:FindFirstChild("Cash")
                local cash = cashVal and cashVal.Value or 0
                
                local categories = {
                    Pickaxes = {
                        { id = "RustyScrapper", price = 0 },
                        { id = "WeatheredWood", price = 25 },
                        { id = "ChippedStone", price = 250 },
                        { id = "HardenedIron", price = 2500 },
                        { id = "CopperPick", price = 24000 },
                        { id = "ReinforcedSteel", price = 220000 },
                        { id = "TitaniumSpike", price = 1900000 },
                        { id = "FrostbitePick", price = 16000000 },
                        { id = "EmeraldCarver", price = 40000000 },
                        { id = "VolcanoBasalt", price = 90000000 },
                        { id = "ObsidianEdge", price = 200000000 },
                        { id = "TempestPick", price = 450000000 },
                        { id = "CelestialApex", price = 1000000000 }
                    },
                    Shovels = {
                        { id = "SplinteredPaddle", price = 0 },
                        { id = "HubcapScooper", price = 400 },
                        { id = "TrenchTrowel", price = 1000 },
                        { id = "FarmsteaderSpade", price = 2500 },
                        { id = "AvalancheBlade", price = 5000 },
                        { id = "FossilExcavator", price = 9000 },
                        { id = "CarbonTrowel", price = 14000 },
                        { id = "PlasmaExcavator", price = 22000 },
                        { id = "SapphireShard", price = 38000 },
                        { id = "HellfireSpade", price = 75000 }
                    },
                    Backpacks = {
                        { id = "MountainPack", price = 0 },
                        { id = "RidgeRucksack", price = 400 },
                        { id = "ScoutSatchel", price = 1000 },
                        { id = "CliffTactical", price = 2500 },
                        { id = "MidnightOperator", price = 5000 },
                        { id = "PeakExpedition", price = 9000 },
                        { id = "SummitCamper", price = 14000 },
                        { id = "ForestHiker", price = 22000 },
                        { id = "RescuePack", price = 38000 },
                        { id = "AlpineMonster", price = 75000 }
                    },
                    Gear = {
                        { id = "JacketBasic", price = 250 },
                        { id = "JacketInsulated", price = 1500 },
                        { id = "JacketExpedition", price = 7500 },
                        { id = "BootsBasic", price = 150 },
                        { id = "BootsCrampons", price = 1200 },
                        { id = "BootsAlpine", price = 5000 }
                    }
                }
                
                local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                local shopBuy = remotes and remotes:FindFirstChild("ShopBuy")
                local shopEquip = remotes and remotes:FindFirstChild("ShopEquip")
                
                if shopBuy and shopEquip and owned then
                    for catName, items in pairs(categories) do
                        
                        local targetBuy = nil
                        for i = #items, 1, -1 do
                            local item = items[i]
                            if not owned:FindFirstChild(item.id) and cash >= item.price then
                                targetBuy = item.id
                                break
                            end
                        end
                        
                        if targetBuy then
                            shopBuy:FireServer(targetBuy)
                            task.wait(0.2)
                        end
                        
                        local bestOwned = nil
                        for i = #items, 1, -1 do
                            local item = items[i]
                            if owned:FindFirstChild(item.id) then
                                bestOwned = item.id
                                break
                            end
                        end
                        
                        if bestOwned then
                            shopEquip:FireServer(bestOwned)
                            task.wait(0.1)
                        end
                    end
                end
            end)
        end
        task.wait(8)
    end
end)

task.spawn(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
    if not Remotes then return end
    
    local StarfallLand = Remotes:WaitForChild("StarfallLand", 5)
    local MeteorEvent = Remotes:WaitForChild("MeteorEvent", 5)
    
    local function generateMeteorCode()
        local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        local code = "Proohio_"
        for i = 1, 6 do
            local rand = math.random(1, #chars)
            code = code .. chars:sub(rand, rand)
        end
        return code
    end

    if StarfallLand and StarfallLand:IsA("RemoteEvent") then
        StarfallLand.OnClientEvent:Connect(function(pos, payout, p3)
            if getgenv().MineAMountainScriptRunning and getgenv().MineAMountainSessionID == sessionID then
                local code = generateMeteorCode()
                
                pcall(function()
                    local folder = workspace:FindFirstChild("Things") and workspace.Things:FindFirstChild("Crystals")
                    if folder then
                        local fake = Instance.new("Part")
                        fake.Name = "StarfallCrash"
                        fake.Size = Vector3.new(4, 4, 4)
                        fake.Position = pos
                        fake.Anchored = true
                        fake.CanCollide = false
                        fake.Transparency = 0.5
                        fake.Color = Color3.fromRGB(255, 255, 0)
                        fake.Material = Enum.Material.Neon
                        fake.Parent = folder
                        
                        fake:SetAttribute("CrystalCode", code)
                        fake:SetAttribute("CrystalName", "Starfall Landing")
                        fake:SetAttribute("Value", payout or 5000)
                        
                        highlightCrystal(fake)
                        game:GetService("Debris"):AddItem(fake, 60)
                    end
                end)
            end
        end)
    end

    if MeteorEvent and MeteorEvent:IsA("RemoteEvent") then
        MeteorEvent.OnClientEvent:Connect(function(event, p1, p2, p3, p4)
            if getgenv().MineAMountainScriptRunning and getgenv().MineAMountainSessionID == sessionID and event == "launch" then
                local pos = p2
                local code = generateMeteorCode()
                
                pcall(function()
                    local folder = workspace:FindFirstChild("Things") and workspace.Things:FindFirstChild("Crystals")
                    if folder then
                        local fake = Instance.new("Part")
                        fake.Name = "MeteorCrash"
                        fake.Size = Vector3.new(p4 or 6, p4 or 6, p4 or 6)
                        fake.Position = pos
                        fake.Anchored = true
                        fake.CanCollide = false
                        fake.Transparency = 0.5
                        fake.Color = Color3.fromRGB(255, 90, 40)
                        fake.Material = Enum.Material.CrackedLava
                        fake.Parent = folder
                        
                        fake:SetAttribute("CrystalCode", code)
                        fake:SetAttribute("CrystalName", "Meteor Crash")
                        fake:SetAttribute("Value", 99999)
                        
                        highlightCrystal(fake)
                        game:GetService("Debris"):AddItem(fake, 60)
                    end
                end)
            end
        end)
    end
end)

task.spawn(function()
    while getgenv().MineAMountainScriptRunning and getgenv().MineAMountainSessionID == sessionID do
        if getgenv().AutoSellEnabled and not isSelling then
            pcall(function()
                if getCurrentWeight() >= getMaxWeight() then
                    isSelling = true
                    local lp = game:GetService("Players").LocalPlayer
                    local char = lp.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                    local goHome = remotes and remotes:FindFirstChild("GoHome")
                    local sellRequest = remotes and remotes:FindFirstChild("SellRequest")
                    
                    if hrp and goHome and sellRequest then
                        local oldCFrame = hrp.CFrame
                        hrp.Anchored = false
                        
                        Rayfield:Notify({
                            Title = "Auto Sell",
                            Content = "Backpack full! Teleporting to sell...",
                            Duration = 2,
                            Image = "alert-circle"
                        })
                        
                        goHome:FireServer("sell")
                        task.wait(1.5)
                        sellRequest:FireServer("all")
                        task.wait(1.0)
                        goHome:FireServer("plot")
                        task.wait(1.5)
                        walkTo(oldCFrame.Position, true, true)
                        
                        Rayfield:Notify({
                            Title = "Auto Sell",
                            Content = "Sold items and returned to farm position!",
                            Duration = 2,
                            Image = "check"
                        })
                    end
                    isSelling = false
                end
            end)
        end
        task.wait(2)
    end
end)

local function isAboutToLand(hrp, char)
    local velY = hrp.AssemblyLinearVelocity.Y
    if velY >= -10 then
        return false
    end
    local rayLength = math.max(15, math.abs(velY) * 0.3)
    local origin = hrp.Position
    local direction = Vector3.new(0, -rayLength, 0)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {char}
    local result = workspace:Raycast(origin, direction, params)
    return result ~= nil
end

getgenv().AntiFallLandingActive = false

task.spawn(function()
    local RunService = game:GetService("RunService")
    RunService.Heartbeat:Connect(function()
        if getgenv().AntiFallDamageEnabled and getgenv().MineAMountainScriptRunning then
            pcall(function()
                local lp = game:GetService("Players").LocalPlayer
                local char = lp.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if hum and hrp then
                    if isAboutToLand(hrp, char) then
                        getgenv().AntiFallLandingActive = true
                    end
                    
                    if getgenv().AntiFallLandingActive then
                        
                        hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
                        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                        
                        local state = hum:GetState()
                        if state == Enum.HumanoidStateType.Freefall or state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.Ragdoll then
                            hum:ChangeState(Enum.HumanoidStateType.Running)
                        end
                        
                        local vel = hrp.AssemblyLinearVelocity
                        if vel.Y < -5 then
                            hrp.AssemblyLinearVelocity = Vector3.new(vel.X, -2, vel.Z)
                        end
                        if hrp.Velocity.Y < -5 then
                            hrp.Velocity = Vector3.new(hrp.Velocity.X, -2, hrp.Velocity.Z)
                        end
                        
                        if hrp.AssemblyLinearVelocity.Y >= -1.5 then
                            if not getgenv()._landingSettling then
                                getgenv()._landingSettling = true
                                task.spawn(function()
                                    task.wait(0.5)
                                    if hrp.Parent and hrp.AssemblyLinearVelocity.Y >= -1.5 then
                                        getgenv().AntiFallLandingActive = false
                                        hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                                        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                                    end
                                    getgenv()._landingSettling = false
                                end)
                            end
                        end
                    else
                        
                        hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                    end
                end
            end)
        end
    end)
end)
