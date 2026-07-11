--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Machine King Prototype  (ID: 89222931)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 3
-- ATK 1600 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains 100 ATK and DEF for each Machine-Type monster on the field, except this card.
--[[ __CARD_HEADER_END__ ]]

--機械王－プロトタイプ
function c89222931.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c89222931.val)
	c:RegisterEffect(e1)
	--defup
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c89222931.val(e,c)
	return Duel.GetMatchingGroupCount(c89222931.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())*100
end
function c89222931.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
