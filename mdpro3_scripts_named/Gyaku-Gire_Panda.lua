--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Gyaku-Gire Panda  (ID: 9817927)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 3
-- ATK 800 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- Increase the ATK of this card by 500 points for each monster on your opponent's side of the field.
-- When this card attacks with an ATK that is higher than the DEF of your opponent's Defense Position
-- monster, inflict the difference as Battle Damage to your opponent's Life Points.
--[[ __CARD_HEADER_END__ ]]

--逆ギレパンダ
function c9817927.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c9817927.val)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c9817927.val(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)*500
end
