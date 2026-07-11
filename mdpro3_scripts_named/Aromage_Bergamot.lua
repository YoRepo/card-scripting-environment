--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Aromage Bergamot  (ID: 85967160)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Plant
-- Level: 6
-- ATK 2400 | DEF 1800
-- Setcode: 0xc9
-- Scope: OCG / TCG
--
-- Effect Text:
-- While your LP is higher than your opponent's, if a Plant monster you control attacks a Defense
-- Position monster, inflict piercing battle damage to your opponent.
-- Once per turn, if you gain LP: This card gains 1000 ATK/DEF until the end of your opponent's turn.
--[[ __CARD_HEADER_END__ ]]

--アロマージ－ベルガモット
function c85967160.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c85967160.pccon)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PLANT))
	c:RegisterEffect(e1)
	--atk & def
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_RECOVER)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c85967160.adcon)
	e2:SetOperation(c85967160.adop)
	c:RegisterEffect(e2)
end
function c85967160.pccon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetLP(tp)>Duel.GetLP(1-tp)
end
function c85967160.adcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c85967160.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
end
