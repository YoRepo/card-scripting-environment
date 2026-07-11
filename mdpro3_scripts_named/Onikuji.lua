--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Onikuji  (ID: 73820802)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during your Standby Phase: Your opponent declares 1 card type (Monster, Spell, or
-- Trap).
-- Excavate the top card of your Deck, then if it is that type of card, your opponent draws 1 card.
-- Otherwise, discard 1 random card from their hand.
-- Place the excavated card on the bottom of your Deck.
--[[ __CARD_HEADER_END__ ]]

--鬼くじ
function c73820802.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_STANDBY_PHASE,0)
	c:RegisterEffect(e1)
	--instant(chain)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(73820802,0))
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_HANDES_OPPO)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetCondition(c73820802.condition)
	e2:SetOperation(c73820802.operation)
	c:RegisterEffect(e2)
end
function c73820802.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c73820802.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CARDTYPE)
	local op=Duel.AnnounceType(1-tp)
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if (op==0 and tc:IsType(TYPE_MONSTER)) or (op==1 and tc:IsType(TYPE_SPELL)) or (op==2 and tc:IsType(TYPE_TRAP)) then
		Duel.Draw(1-tp,1,REASON_EFFECT)
	else
		local hg=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
		if hg:GetCount()>0 then
			local sg=hg:RandomSelect(1-tp,1)
			Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
		end
	end
	Duel.MoveSequence(tc,SEQ_DECKBOTTOM)
end
