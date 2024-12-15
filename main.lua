local buttonSize = 32
local buttonPadding = 2
local healthstones = {"Create Healthstone (Minor)", "Create Healthstone (Lesser)", "Create Healthstone", "Create Healthstone (Greater)", "Create Healthstone (Major)"}
local frame = CreateFrame("Frame", "Backdrop", UIParent, "BackdropTemplate")

frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetPoint("BOTTOMRIGHT")
frame:SetHeight(buttonSize)
frame:SetScript("OnDragStart", function(self)
    print("drag")
    self:StartMoving()
end)
frame:SetScript("OnDragStop", function(self)
    print("drag stop")
    self:StopMovingOrSizing()
end)

function GetHighestLevelHealthstone()
    local spellinfo
    for i = 1, #healthstones do
        -- highestRankSpell = spell[spellIndex]
        local tmpSpellInfo = C_Spell.GetSpellInfo(healthstones[i])
        if tmpSpellInfo ~= nil and IsSpellKnown(tmpSpellInfo.spellID) then
            spellinfo = tmpSpellInfo
        end
    end
    return spellinfo.name
end
function CreateButtonForSpell(spellinfo, i)
    local button = CreateFrame("Button", spellinfo.name .. "button", frame, "SecureActionButtonTemplate")
    button:SetSize(buttonSize, buttonSize)  -- Set button size (adjust as needed)
    button:SetPoint("LEFT", frame, "LEFT", ((i-1)*(buttonSize + buttonPadding)), 0)  -- Position the button on screen

    local icon = button:CreateTexture(nil, "BACKGROUND")
    icon:SetAllPoints()
    icon:SetTexture(spellinfo.iconID)
    
    button:SetAttribute("type", "spell")  -- Set the type of action (casting a spell)
    button:SetAttribute("spell", spellinfo.spellID)  -- Replace with the spell you want to cast
    
    button:Show()

    button:SetScript("OnEnter", function (self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        -- GameTooltip:SetText(spellinfo.name, 1, 1, 1)
        GameTooltip:SetSpellByID(spellinfo.spellID)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    local cooldown = CreateFrame("Cooldown", spellinfo.name .. "cooldown", frame, "CooldownFrameTemplate")
    cooldown:SetAllPoints()

    frame:SetWidth(i * (buttonSize + buttonPadding))
end
local spells = {"Ritual Of Summoning", "Create Soulstone", GetHighestLevelHealthstone(), "Summon Imp", "Summon Voidwalker", "Summon Succubus", "Summon Felhunter"}
for i=1, #spells do
    local spellinfo = C_Spell.GetSpellInfo(spells[i])
    CreateButtonForSpell(spellinfo, i)

end