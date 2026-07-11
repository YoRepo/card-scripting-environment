--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Firebrand Hymnist  (ID: 373085)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 3
-- ATK 800 | DEF 200
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can send cards from the top of your opponent's Deck to the
-- GY, equal to the number of cards they control.
-- If this card is Special Summoned: You can send cards from the top of your Deck to the GY, equal to
-- the number of cards your opponent controls.
-- You can only use this effect of "Firebrand Hymnist" once per turn.
--[[ __CARD_HEADER_END__ ]]

--讃美火
function c373085.initial_effect(c)
	--discard oppo deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(373085,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c373085.distg1)
	e1:SetOperation(c373085.disop1)
	c:RegisterEffect(e1)
	--discard self deck
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(373085,1))
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,373085)
	e2:SetTarget(c373085.distg2)
	e2:SetOperation(c373085.disop2)
	c:RegisterEffect(e2)
end
function c373085.distg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	if chk==0 then return ct>0 and Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)>=ct and Duel.IsPlayerCanDiscardDeck(1-tp,ct) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,ct)
end
function c373085.disop1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	if ct>0 then
		Duel.DiscardDeck(1-tp,ct,REASON_EFFECT)
	end
end
function c373085.distg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	if chk==0 then return ct>0 and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=ct and Duel.IsPlayerCanDiscardDeck(tp,ct) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,ct)
end
function c373085.disop2(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	if ct>0 then
		Duel.DiscardDeck(tp,ct,REASON_EFFECT)
	end
end
