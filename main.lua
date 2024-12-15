local buttonSize = 32
local buttonPadding = 2
local healthstones = {"Create Healthstone (Minor)", "Create Healthstone (Lesser)", "Create Healthstone", "Create Healthstone (Greater)", "Create Healthstone (Major)"}
local spells = {"Ritual Of Summoning", "Create Soulstone", healthstones, "Summon Imp", "Summon Voidwalker", "Summon Succubus", "Summon Felhunter"}
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

function IsArray(t)
    if type(t) ~= "table" then
        return false
    end
    local i = 1
    for key in pairs(t) do
        if key ~= i then
            return false
        end
        i = i+1
    end
    return true
end

function CreateButtonForSpell(spell, i)
    local highestRankSpell = spell
    local spellinfo
    if IsArray(spell) then
        for spellIndex = 1, #spell do
            highestRankSpell = spell[spellIndex]
            local tmpSpellInfo = C_Spell.GetSpellInfo(spell[spellIndex])
            if tmpSpellInfo ~= nil and IsSpellKnown(tmpSpellInfo.spellID) then
                highestRankSpell = spell[spellIndex]
                spellinfo = C_Spell.GetSpellInfo(highestRankSpell)
            end
        end
    else
        highestRankSpell = spell
        spellinfo = C_Spell.GetSpellInfo(highestRankSpell)
    end
    
    local button = CreateFrame("Button", "MySpellButton", frame, "SecureActionButtonTemplate")
    button:SetSize(buttonSize, buttonSize)  -- Set button size (adjust as needed)
    button:SetPoint("LEFT", frame, "LEFT", ((i-1)*(buttonSize + buttonPadding)), 0)  -- Position the button on screen

    -- Set the button's icon (optional)
    local icon = button:CreateTexture(nil, "BACKGROUND")
    icon:SetAllPoints()
--    icon:SetTexture("Interface\\Icons\\Spell_Nature_MoonGlow")  -- Replace with the appropriate spell icon
    icon:SetTexture(spellinfo.iconID)
    -- Set up the button to cast a spell
    button:SetAttribute("type", "spell")  -- Set the type of action (casting a spell)
    button:SetAttribute("spell", spell)  -- Replace with the spell you want to cast

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

    frame:SetWidth(i * (buttonSize + buttonPadding))
end
for i=1, #spells do
    CreateButtonForSpell(spells[i], i)
end