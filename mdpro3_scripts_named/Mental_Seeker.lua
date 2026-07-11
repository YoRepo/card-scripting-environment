--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Mental Seeker  (ID: 36565699)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Psychic
-- Level: 3
-- ATK 800 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this banished card is Special Summoned: Excavate the top 3 cards of your opponent's Deck, banish
-- 1 excavated card, and shuffle the rest into the Deck.
--[[ __CARD_HEADER_END__ ]]

--メンタルシーカー
function c36565699.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36565699,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c36565699.condition)
	e1:SetTarget(c36565699.target)
	e1:SetOperation(c36565699.activate)
	c:RegisterEffect(e1)
end
function c36565699.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_REMOVED)
end
function c36565699.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,LOCATION_DECK)
end
function c36565699.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(1-tp,3)
	local g=Duel.GetDecktopGroup(1-tp,3)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=g:FilterSelect(tp,Card.IsAbleToRemove,1,1,nil)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		Duel.ShuffleDeck(1-tp)
	end
end
