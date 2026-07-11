--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Fabled Urustos  (ID: 73040500)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level: 4
-- ATK 1500 | DEF 200
-- Setcode: 0x35
-- Scope: OCG / TCG
--
-- Effect Text:
-- While you have 2 or less cards in your hand, all face-up "Fabled" monsters you control gain 400 ATK.
--[[ __CARD_HEADER_END__ ]]

--魔轟神ウルストス
function c73040500.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c73040500.con)
	e1:SetTarget(c73040500.tg)
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
function c73040500.con(e)
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)<=2
end
function c73040500.tg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x35)
end
