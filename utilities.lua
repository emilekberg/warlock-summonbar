ITEMID_SOUL_SHARD = 6265
BUTTON_SIZE = 32
BUTTON_PADDING = 2
function IsPlayerWarlock()
    local _, _, id = UnitClass("player")
    local CLASSID_WARLOCK = 9;
    return id == CLASSID_WARLOCK
end
function GetHighestLevelHealthstone()
    local healthstones = {"Create Healthstone (Minor)", "Create Healthstone (Lesser)", "Create Healthstone", "Create Healthstone (Greater)", "Create Healthstone (Major)"}
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
function CreateToggleButton(itemInfo, parentFrame)
    local button = CreateFrame("Button", "button", parentFrame, "BackdropTemplate")
    local overlayText = button:CreateFontString("ITEM_COUNT", "OVERLAY", "GameFontHighlight")
    button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
    button:SetPoint("LEFT", parentFrame, "LEFT", 7 * (BUTTON_SIZE + BUTTON_PADDING), 0)
    button:RegisterEvent("BAG_UPDATE")
    button:SetScript("OnEvent", function(self, event)
        local itemCount = C_Item.GetItemCount(ITEMID_SOUL_SHARD)
        --local overlayText = button:CreateFontString("ITEM_COUNT", "OVERLAY", "GameFontHighlight")
        overlayText:SetPoint("CENTER", button, "CENTER") 
        overlayText:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
        overlayText:SetText("" .. itemCount)
    end)

    local icon = button:CreateTexture(nil, "BACKGROUND")
    icon:SetAllPoints()
    icon:SetTexture(itemInfo)

    local itemCount = C_Item.GetItemCount(ITEMID_SOUL_SHARD)
    overlayText:SetPoint("CENTER", button, "CENTER") 
    overlayText:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    overlayText:SetText("" .. itemCount)

    button:SetScript("OnEnter", function (self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetItemByID(ITEMID_SOUL_SHARD)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    button:Show()
end
function CreateButtonSpellcast(spellinfo, parentFrame, offset)
    local button = CreateFrame("Button", spellinfo.name .. "button", parentFrame, "SecureActionButtonTemplate")
    button:SetSize(BUTTON_SIZE, BUTTON_SIZE)  -- Set button size (adjust as needed)
    button:SetPoint("LEFT", parentFrame, "LEFT", ((offset-1)*(BUTTON_SIZE + BUTTON_PADDING)), 0)  -- Position the button on screen

    local icon = button:CreateTexture(nil, "BACKGROUND")
    icon:SetAllPoints()
    icon:SetTexture(spellinfo.iconID)
    
    button:SetAttribute("type", "spell")  -- Set the type of action (casting a spell)
    button:SetAttribute("spell", spellinfo.spellID)  -- Replace with the spell you want to cast
    
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
    button:Show()
end