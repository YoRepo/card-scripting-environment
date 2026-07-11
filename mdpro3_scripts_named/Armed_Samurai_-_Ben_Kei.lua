--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Armed Samurai - Ben Kei  (ID: 84430950)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 4
-- ATK 500 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- For each Equip Card equipped to this card, it gains 1 additional attack during each Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--重装武者－ベン・ケイ
function c84430950.initial_effect(c)
	--multi attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(c84430950.val)
	c:RegisterEffect(e1)
end
function c84430950.val(e,c)
	return c:GetEquipCount()
end
