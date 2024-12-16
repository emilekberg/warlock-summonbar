if IsPlayerWarlock() == false then
    return
end

local ITEMID_SOUL_SHARD = 6265
local healthstones = {"Create Healthstone (Minor)", "Create Healthstone (Lesser)", "Create Healthstone", "Create Healthstone (Greater)", "Create Healthstone (Major)"}
local frame = CreateFrame("Frame", "Backdrop", UIParent, "BackdropTemplate")

frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetPoint("BOTTOMRIGHT")
frame:SetWidth(BUTTON_SIZE)
frame:SetHeight(BUTTON_SIZE)
frame:SetScript("OnDragStart", function(self)
    print("drag")
    self:StartMoving()
end)
frame:SetScript("OnDragStop", function(self)
    print("drag stop")
    self:StopMovingOrSizing()
end)
local spells = {"Ritual Of Summoning", "Create Soulstone", GetHighestLevelHealthstone(), "Summon Imp", "Summon Voidwalker", "Summon Succubus", "Summon Felhunter"}
for i=1, #spells do
    local spellinfo = C_Spell.GetSpellInfo(spells[i])
    CreateButtonSpellcast(spellinfo, frame, i)
    frame:SetWidth((i+1) * (BUTTON_SIZE + BUTTON_PADDING))
end

local itemInfo = Item:CreateFromItemID(ITEMID_SOUL_SHARD)

itemInfo:ContinueOnItemLoad(function()
    CreateToggleButton(itemInfo:GetItemIcon(), frame)
end)


