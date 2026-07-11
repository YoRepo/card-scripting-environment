--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Ominous Fortunetelling  (ID: 56995655)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Standby Phase, select 1 random card from your opponent's hand.
-- Call the type of card (Monster, Spell, or Trap).
-- If you call it right, inflict 700 points of damage to your opponent's Life Points.
-- You can use this effect only once per turn.
--[[ __CARD_HEADER_END__ ]]

--不吉な占い
function c56995655.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)
	--call & damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56995655,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCondition(c56995655.con)
	e2:SetOperation(c56995655.op)
	c:RegisterEffect(e2)
end
function c56995655.con(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c56995655.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	local op=Duel.AnnounceType(tp)
	Duel.ConfirmCards(tp,tc)
	Duel.ShuffleHand(1-tp)
	if (op==0 and tc:IsType(TYPE_MONSTER)) or (op==1 and tc:IsType(TYPE_SPELL)) or (op==2 and tc:IsType(TYPE_TRAP)) then
		Duel.Damage(1-tp,700,REASON_EFFECT)
	end
end
