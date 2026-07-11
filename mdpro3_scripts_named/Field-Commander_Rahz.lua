--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Field-Commander Rahz  (ID: 89529919)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1600 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal or Special Summoned: Choose 1 Level 4 or lower Warrior-Type monster from
-- your Deck, except "Field-Commander Rahz", and place it on top of your Deck.
--[[ __CARD_HEADER_END__ ]]

--戦士ラーズ
function c89529919.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89529919,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c89529919.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c89529919.filter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_WARRIOR) and not c:IsCode(89529919)
end
function c89529919.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(89529919,1))
	local g=Duel.SelectMatchingCard(tp,c89529919.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,SEQ_DECKTOP)
		Duel.ConfirmDecktop(tp,1)
	end
end
