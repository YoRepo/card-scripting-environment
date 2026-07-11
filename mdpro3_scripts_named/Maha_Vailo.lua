--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Maha Vailo  (ID: 93013676)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 4
-- ATK 1550 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 500 ATK for each Equip Card equipped to this card.
--[[ __CARD_HEADER_END__ ]]

--マハー・ヴァイロ
function c93013676.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c93013676.val)
	c:RegisterEffect(e1)
end
function c93013676.val(e,c)
	return c:GetEquipCount()*500
end
