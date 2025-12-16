local addonName, ns = ...
local trinketData = ns.trinketData

local LCG = LibStub("LibCustomGlow-1.0")
local Glow_Start = LCG.PixelGlow_Start
local Glow_Stop = LCG.PixelGlow_Stop
local color, lines, frequency, length, thickness, xOffset, yOffset = nil, 6, 0.2, 20, 1.5, -1, -1

local CreateFrame, UnitName, GetRealmName, UnitBuff, GetInventoryItemID, GetInventoryItemCooldown, GetTime, ipairs, print, tonumber, math_max, math_min  = 
      CreateFrame, UnitName, GetRealmName, UnitBuff, GetInventoryItemID, GetInventoryItemCooldown, GetTime, ipairs, print, tonumber, math.max, math.min

local Addon = CreateFrame("Frame")
local playerKey = UnitName("player") .. " - " .. GetRealmName()

local WrapperFrame = CreateFrame("Frame", nil, UIParent)
WrapperFrame:SetSize(135, 70)
WrapperFrame:SetMovable(true)
WrapperFrame:EnableMouse(true)
WrapperFrame:SetClampedToScreen(true)
WrapperFrame:RegisterForDrag("LeftButton")
WrapperFrame.isLocked = true
WrapperFrame:SetScript("OnDragStart", function(self)
    if not self.isLocked then
        self:StartMoving()
    end
end)
WrapperFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local frameX, frameY = self:GetCenter()
    local uiX, uiY = UIParent:GetCenter()
    TrinketWatcherDB[playerKey].x = frameX - uiX
    TrinketWatcherDB[playerKey].y = frameY - uiY
end)

local ParentFrame = CreateFrame("Frame", nil, WrapperFrame)
ParentFrame:SetSize(135, 70)
ParentFrame:SetPoint("CENTER")
ParentFrame:SetFrameStrata("DIALOG")
local hitbox = ParentFrame:CreateTexture(nil, "OVERLAY")
hitbox:SetAllPoints(true)
hitbox:SetTexture(0, 0.5, 0, 0.5)
hitbox:Hide()
local moveText = ParentFrame:CreateFontString(nil, "OVERLAY")
moveText:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
moveText:SetText("DRAG")
moveText:SetPoint("CENTER")
moveText:SetTextColor(1, 1, 1)
moveText:Hide()

local Icon1 = CreateFrame("Frame", nil, ParentFrame)
local Icon2 = CreateFrame("Frame", nil, ParentFrame)
Icon1:SetPoint("CENTER", ParentFrame, "CENTER", -32.5, 0)
Icon2:SetPoint("CENTER", ParentFrame, "CENTER", 32.5, 0)
local Icons = {Icon1, Icon2}

local function SetupTrinketIcon(icon, slot)
    icon:SetSize(60, 60)
    icon:Hide()
    icon:SetFrameStrata("HIGH")
    icon:SetBackdrop({ edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 4 })
    icon:SetBackdropBorderColor(0, 0, 0, 1)
    icon.tex = icon:CreateTexture(nil, "BACKGROUND")
    icon.tex:SetAllPoints()
    icon.tex:SetTexCoord(0.015, 0.985, 0.015, 0.985)
    icon.cd = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
    icon.cd:SetAllPoints()
    icon.cd:SetDrawEdge(true)
    icon.overlayFrame = CreateFrame("Frame", nil, icon)
    icon.overlayFrame:SetAllPoints()
    icon.overlayFrame:SetFrameLevel(icon:GetFrameLevel() + 1)
    icon.stacks = icon.overlayFrame:CreateFontString(nil, "OVERLAY")
    icon.stacks:SetFont("Fonts\\FRIZQT__.TTF", 28, "OUTLINE")
    icon.stacks:SetPoint("CENTER", 0, 30)
    icon.stacks:SetText("")
    icon.stacks:Hide()
    icon.slot = slot
    icon.currentTrinket = nil
    icon.state = {
        ICDstartTime = nil,
        ICDendTime = nil,
        remainingCD = 0,
        elapsedCDView = 0,
        buffActive = false,
        expirationTimeLast = 0,
        stacksLast = 0
    }
end

local function SetIconTex(icon, tex, desaturated, reverse)
    icon.tex:SetTexture(tex)
    icon.tex:SetDesaturated(desaturated)
    icon.cd:SetReverse(reverse)
end

local function SetupCDViewer(icon)
    icon.CDViewer = CreateFrame("Frame")
    icon.CDViewer:Hide()
    icon.CDViewer:SetScript("OnUpdate", function(self, elapsed)
        icon.state.elapsedCDView = icon.state.elapsedCDView + elapsed
        if icon.state.elapsedCDView >= icon.state.remainingCD then
            SetIconTex(icon, icon.currentTrinket.itemTex, false, false)
            icon.state.ICDstartTime = nil
            icon.state.ICDendTime = nil
            self:Hide()
        end
    end)
end

local function Initialize()
    TrinketWatcherDB = TrinketWatcherDB or {}
    TrinketWatcherDB[playerKey] = TrinketWatcherDB[playerKey] or { x = 0, y = 0, scale = 1 }
    local db = TrinketWatcherDB[playerKey]
    WrapperFrame:ClearAllPoints()
    WrapperFrame:SetPoint("CENTER", UIParent, "CENTER", db.x, db.y)
    WrapperFrame:SetSize(135 * db.scale, 70 * db.scale)
    ParentFrame:SetScale(db.scale)
    SetupTrinketIcon(Icon1, 13)
    SetupTrinketIcon(Icon2, 14)
    SetupCDViewer(Icon1)
    SetupCDViewer(Icon2)
end

local function PlayerBuffCheck(buffHash)
    if not buffHash then return end
    local i = 1
    while true do
        local _, _, _, stacks, _, duration, expirationTime, _, _, _, spellID = UnitBuff("player", i)
        if not spellID then break end
        if buffHash[spellID] then
            return expirationTime, duration, spellID, stacks
        end
        i = i + 1
    end
end

local function CheckTrinketState(icon, slot, trinketChanged)
    local state = icon.state
    icon.currentTrinket = trinketData[GetInventoryItemID("player", slot)]
    local currentTrinket = icon.currentTrinket
    if trinketChanged then
        state.expirationTimeLast = 0
        state.stacksLast = 0
        icon.stacks:Hide()
    end
    if not currentTrinket then
        icon:Hide()
        Glow_Stop(icon)
        state.ICDstartTime, state.ICDendTime = nil
        state.remainingCD, state.elapsedCDView = 0, 0
        icon.CDViewer:Hide()
        return
    end
    icon:Show()
    local expirationTime, buffDuration, spellID, stacks = PlayerBuffCheck(currentTrinket.buff)
    state.buffActive = expirationTime ~= nil
    if state.buffActive then
        SetIconTex(icon, currentTrinket.buff[spellID], false, buffDuration > 0)
        if currentTrinket.ICD ~= 0 then
            Glow_Start(icon, color, lines, frequency, length, thickness, xOffset, yOffset)  
        else
            Glow_Stop(icon) 
        end
        icon.cd:SetCooldown(expirationTime - buffDuration, buffDuration)
        if currentTrinket.ICD and currentTrinket.ICD > 0 then
            if trinketChanged then
                state.ICDstartTime = GetTime()
            else
                state.ICDstartTime = expirationTime - buffDuration  
            end
            state.ICDendTime = state.ICDstartTime + currentTrinket.ICD
        else
            state.expirationTimeLast = expirationTime
            if stacks > 0 then
                state.stacksLast = stacks
                icon.stacks:SetText(stacks)
                icon.stacks:Show()
            end
        end
        return
    end
    Glow_Stop(icon)
    if currentTrinket.ICD and currentTrinket.ICD > 0 and trinketChanged then
        state.ICDstartTime = GetTime()
        state.ICDendTime = state.ICDstartTime + currentTrinket.ICD
        SetIconTex(icon, currentTrinket.itemTex, true, false)
        icon.cd:SetCooldown(state.ICDstartTime, currentTrinket.ICD)
        state.remainingCD = currentTrinket.ICD
        state.elapsedCDView = 0
        icon.CDViewer:Show()
        return
    end
    if not currentTrinket.ICD then
        local CDstartTime, CDduration = GetInventoryItemCooldown("player", slot)
        if CDduration > 0 then
            SetIconTex(icon, currentTrinket.itemTex, true, false)
            icon.cd:SetCooldown(CDstartTime, CDduration)
            state.remainingCD = CDstartTime + CDduration - GetTime()
            state.elapsedCDView = 0
            icon.CDViewer:Show()           
            return
        end
    end
    SetIconTex(icon, currentTrinket.itemTex, false, false)
    if trinketChanged then icon.cd:SetCooldown(0, 0) end
end

local function UpdateIconLayout()
    local has1 = Icon1.currentTrinket
    local has2 = Icon2.currentTrinket
    if has1 and has2 then
        Icon1:ClearAllPoints()
        Icon1:SetPoint("CENTER", ParentFrame, "CENTER", -32.5, 0)
        Icon2:ClearAllPoints()
        Icon2:SetPoint("CENTER", ParentFrame, "CENTER", 32.5, 0)
    elseif has1 then
        Icon1:ClearAllPoints()
        Icon1:SetPoint("CENTER", ParentFrame, "CENTER", 0, 0)
    elseif has2 then
        Icon2:ClearAllPoints()
        Icon2:SetPoint("CENTER", ParentFrame, "CENTER", 0, 0)
    end
end

local function TrinketBuffApplied(icon, expirationTime, buffDuration, spellID, stacks)
    local currentTrinket = icon.currentTrinket
    local state = icon.state
    state.buffActive = true
    icon.CDViewer:Hide()
    SetIconTex(icon, currentTrinket.buff[spellID], false, buffDuration > 0)
    if currentTrinket.ICD ~= 0 then Glow_Start(icon, color, lines, frequency, length, thickness, xOffset, yOffset) end
    icon.cd:SetCooldown(expirationTime - buffDuration, buffDuration)
    if currentTrinket.ICD and currentTrinket.ICD > 0 then
        if not state.ICDstartTime then
            state.ICDstartTime = expirationTime - buffDuration
            state.ICDendTime = state.ICDstartTime + currentTrinket.ICD
        end
    elseif currentTrinket.ICD == 0 then
        state.expirationTimeLast = expirationTime
        if stacks > 0 then
            state.stacksLast = stacks
            icon.stacks:SetText(stacks)
            icon.stacks:Show()
        end
    end
end

local function TrinketBuffRefresh(icon, expirationTime, buffDuration, stacks)
    local state = icon.state
    icon.cd:SetCooldown(expirationTime - buffDuration, buffDuration)
    state.expirationTimeLast = expirationTime
    if stacks > 0 then
        state.stacksLast = stacks
        icon.stacks:SetText(stacks)
        icon.stacks:Show()
    end
end

local function TrinketBuffRemoved(icon)
    local currentTrinket = icon.currentTrinket
    local state = icon.state
    state.buffActive = false
    if currentTrinket.ICD == 0 then
        state.expirationTimeLast = 0
        state.stacksLast = 0
        icon.stacks:Hide()
    end
    SetIconTex(icon, currentTrinket.itemTex, true, false)
    Glow_Stop(icon)
    if currentTrinket.ICD and currentTrinket.ICD > 0 and state.ICDendTime > GetTime() then
        icon.cd:SetCooldown(state.ICDstartTime, currentTrinket.ICD)
        state.remainingCD = state.ICDendTime - GetTime()
    else
        local CDstartTime, CDduration = GetInventoryItemCooldown("player", icon.slot)
        icon.cd:SetCooldown(CDstartTime, CDduration)
        state.remainingCD = CDstartTime + CDduration - GetTime()
    end
    state.elapsedCDView = 0
    icon.CDViewer:Show()
end

local function TrinketSpellUsed(icon)
    local currentTrinket = icon.currentTrinket
    local state = icon.state
    SetIconTex(icon, currentTrinket.itemTex, true, false)
    state.remainingCD = currentTrinket.CD
    icon.cd:SetCooldown(GetTime(), state.remainingCD)
    state.elapsedCDView = 0
    icon.CDViewer:Show()
end

Addon:RegisterEvent("ADDON_LOADED")
Addon:RegisterEvent("PLAYER_ENTERING_WORLD")
Addon:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
Addon:RegisterEvent("UNIT_AURA")
Addon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
Addon:SetScript("OnEvent", function(self, event, arg1, arg2)
    if event == "ADDON_LOADED" and arg1 == addonName then
        Initialize()
        self:UnregisterEvent("ADDON_LOADED")
        return
    end
    for _, icon in ipairs(Icons) do
        local slot = icon.slot        
        local currentTrinket = icon.currentTrinket
        local state = icon.state
        if event == "PLAYER_ENTERING_WORLD" then
            CheckTrinketState(icon, slot)
            UpdateIconLayout()
        elseif event == "PLAYER_EQUIPMENT_CHANGED" and arg1 == slot then
            CheckTrinketState(icon, slot, true)
            UpdateIconLayout()
        elseif event == "UNIT_AURA" and arg1 == "player" and currentTrinket and currentTrinket.buff then
            local expirationTime, buffDuration, spellID, stacks = PlayerBuffCheck(currentTrinket.buff)
            if expirationTime and not state.buffActive then
                TrinketBuffApplied(icon, expirationTime, buffDuration, spellID, stacks)
            elseif expirationTime and currentTrinket.ICD == 0 and (stacks > state.stacksLast or expirationTime > state.expirationTimeLast) then
                TrinketBuffRefresh(icon, expirationTime, buffDuration, stacks)
            elseif not expirationTime and state.buffActive then
                TrinketBuffRemoved(icon)
            end
        elseif event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and currentTrinket and currentTrinket.castName and currentTrinket.castName == arg2 then
            TrinketSpellUsed(icon)
        end
    end
end)

local HelpTextList = {
    '  |cff8788ee========= TrinketWatcher Commands =========|r',
    '  |cff00FF98 /tw unlock|r : Enable dragging the icon frame',
    '  |cff00FF98 /tw lock|r : Lock and save the frame position',
    '  |cff00FF98 /tw scale #|r : Set icon scale (0.5 to 2)',
    '  |cff8788ee=========================================|r'
}

local function TWprint(...)
	print("|cff00FF98[TrinketWatcher]:|r", ...)
end

SLASH_TRINKETWATCHER1 = "/tw"
SlashCmdList["TRINKETWATCHER"] = function(msg)
    local cmd, rest = msg:match("^(%S+)%s*(.-)$")
    if cmd == "unlock" then
        WrapperFrame.isLocked = false
        hitbox:Show()
        moveText:Show()
        TWprint("Frame unlocked")
    elseif cmd == "lock" then
        WrapperFrame.isLocked = true
        hitbox:Hide()
        moveText:Hide()
        TWprint("Frame locked")
    elseif cmd == "scale" then
        if rest == "" then
            TWprint("Current scale is " .. TrinketWatcherDB[playerKey].scale)
        else
            local scale = tonumber(rest)
            if scale then
                scale = math_max(0.5, math_min(2, scale))
                TrinketWatcherDB[playerKey].scale = scale
                ParentFrame:SetScale(scale)
                WrapperFrame:SetSize(135 * scale, 70 * scale)
                TWprint("Scale set to " .. scale)
            else
                TWprint("Invalid scale value")
            end
        end
    else
        for _, line in ipairs(HelpTextList) do
            print(line)
        end
    end
end