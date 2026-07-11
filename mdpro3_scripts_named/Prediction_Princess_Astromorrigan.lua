--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Prediction Princess Astromorrigan  (ID: 5010422)
-- Type: Monster / Effect / Flip
-- Attribute: DARK
-- Race: Fairy
-- Level: 3
-- ATK 1300 | DEF 0
-- Setcode: 0xcc
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: During the End Phase of this turn, destroy as many Defense Position monsters your opponent
-- controls as possible, and if you do, inflict 500 damage to your opponent for each monster destroyed.
--[[ __CARD_HEADER_END__ ]]

--占術姫ウィジャモリガン
function c5010422.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c5010422.flipop)
	c:RegisterEffect(e1)
end
function c5010422.flipop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c5010422.desop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c5010422.desfilter(c)
	return c:IsDefensePos()
end
function c5010422.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c5010422.desfilter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_CARD,0,5010422)
		local ct=Duel.Destroy(g,REASON_EFFECT)
		Duel.Damage(1-tp,ct*500,REASON_EFFECT)
	end
end
