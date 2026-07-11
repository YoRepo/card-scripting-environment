--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Lord of D.  (ID: 17985575)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 1200 | DEF 1100
-- Scope: OCG / TCG
--
-- Effect Text:
-- Neither player can target Dragon monsters on the field with card effects.
--[[ __CARD_HEADER_END__ ]]

--ロード・オブ・ドラゴン－ドラゴンの支配者－
function c17985575.initial_effect(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c17985575.etarget)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c17985575.etarget(e,c)
	return c:IsRace(RACE_DRAGON)
end
