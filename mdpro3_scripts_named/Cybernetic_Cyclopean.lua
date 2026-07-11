--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Cybernetic Cyclopean  (ID: 96428622)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1400 | DEF 200
-- Setcode: 0x94
-- Scope: OCG / TCG
--
-- Effect Text:
-- While you have no cards in your hand, this card gains 1000 ATK.
--[[ __CARD_HEADER_END__ ]]

--サイバネティック・サイクロプス
function c96428622.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1000)
	e1:SetCondition(c96428622.atkcon)
	c:RegisterEffect(e1)
end
function c96428622.atkcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)==0
end
