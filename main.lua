if IsPlayerWarlock() == false then
    return
end
local buttons = {}
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
frame:RegisterEvent("BAG_UPDATE")
frame:SetScript("OnEvent", function(self, event, ...)
    if event ~= "BAG_UPDATE" then
        return
    end
    local numberOfSoulShards = C_Item.GetItemCount(ITEMID_SOUL_SHARD)
    if numberOfSoulShards == 0 then
        -- no soulshards
        -- gray all the buttons, set text to 0
    else
        -- has some shards.
        -- enable all the button
        -- set text to corrent number
    end
end)





local spells = {"Ritual Of Summoning", GetHighestLevelSoulStone(), GetHighestLevelHealthstone(), "Summon Imp", "Summon Voidwalker", "Summon Succubus", "Summon Felhunter"}
for i=1, #spells do
    local spellinfo = C_Spell.GetSpellInfo(spells[i])
    local button = CreateButtonSpellcast(spellinfo, frame, i)
    table.insert(buttons, button)
end
frame:SetWidth((#buttons+1) * (BUTTON_SIZE + BUTTON_PADDING))

local itemInfo = Item:CreateFromItemID(ITEMID_SOUL_SHARD)
itemInfo:ContinueOnItemLoad(function()
    CreateToggleButton(itemInfo:GetItemIcon(), frame)
end)




-- local altClickFrame = CreateFrame("Frame", "Backdrop")