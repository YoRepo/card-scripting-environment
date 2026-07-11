--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Elemental HERO Heat  (ID: 98266377)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 4
-- ATK 1600 | DEF 1200
-- Setcode: 0x3008
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains 200 ATK for each "Elemental HERO" monster you control.
--[[ __CARD_HEADER_END__ ]]

--E・HERO ザ・ヒート
function c98266377.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c98266377.val)
	c:RegisterEffect(e1)
end
function c98266377.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3008)
end
function c98266377.val(e,c)
	return Duel.GetMatchingGroupCount(c98266377.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
