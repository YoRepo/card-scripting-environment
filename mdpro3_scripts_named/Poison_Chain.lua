--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Poison Chain  (ID: 33302407)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- During the End Phase of your turn, if you did not attack, you can make your opponent send cards
-- equal to the number of face-up "Iron Chain" monsters you control from the top of their Deck to the
-- Graveyard.
--[[ __CARD_HEADER_END__ ]]

--ポイズン・チェーン
function c33302407.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--discard deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33302407,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c33302407.discon)
	e2:SetTarget(c33302407.distg)
	e2:SetOperation(c33302407.disop)
	c:RegisterEffect(e2)
end
function c33302407.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetActivityCount(tp,ACTIVITY_ATTACK)==0
end
function c33302407.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x25)
end
function c33302407.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c33302407.filter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return ct>0 and Duel.IsPlayerCanDiscardDeck(1-tp,ct) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,ct)
end
function c33302407.disop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c33302407.filter,tp,LOCATION_MZONE,0,nil)
	if ct>0 then
		Duel.DiscardDeck(1-tp,ct,REASON_EFFECT)
	end
end
