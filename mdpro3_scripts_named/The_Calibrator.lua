--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: The Calibrator  (ID: 54706054)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 4
-- ATK 1500 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains ATK equal to the combined Ranks of all face-up Xyz Monsters your opponent controls x
-- 300.
--[[ __CARD_HEADER_END__ ]]

--ザ・キャリブレーター
function c54706054.initial_effect(c)
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c54706054.atkval)
	c:RegisterEffect(e1)
end
function c54706054.atkval(e,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),0,LOCATION_MZONE,nil)
	return g:GetSum(Card.GetRank)*300
end
