--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Dark Magician Girl  (ID: 38033121)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 6
-- ATK 2000 | DEF 1700
-- Setcode: 0x30a2
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 300 ATK for every "Dark Magician" or "Magician of Black Chaos" in the GYs.
--[[ __CARD_HEADER_END__ ]]

--ブラック・マジシャン・ガール
function c38033121.initial_effect(c)
	aux.AddCodeList(c,46986414)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c38033121.val)
	c:RegisterEffect(e1)
end
function c38033121.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil,30208479,46986414)*300
end
