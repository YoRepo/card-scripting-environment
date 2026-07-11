--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Spiritual Beast Rampengu  (ID: 88123329)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Beast
-- Level: 4
-- ATK 1600 | DEF 400
-- Setcode: 0x20b5
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during your Main Phase: You can banish 1 "Ritual Beast" monster from your Extra Deck
-- and send 1 "Ritual Beast" monster with the same Type as that monster from your Deck to the GY.
-- You can only Special Summon "Spiritual Beast Rampengu(s)" once per turn.
--[[ __CARD_HEADER_END__ ]]

--精霊獣 ラムペンタ
function c88123329.initial_effect(c)
	c:SetSPSummonOnce(88123329)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c88123329.target)
	e1:SetOperation(c88123329.operation)
	c:RegisterEffect(e1)
end
function c88123329.tgfilter(c,rac)
	return c:IsSetCard(0xb5) and c:IsRace(rac) and c:IsAbleToGrave()
end
function c88123329.rmfilter(c,tp)
	return c:IsSetCard(0xb5) and c:IsAbleToRemove()
		and Duel.IsExistingMatchingCard(c88123329.tgfilter,tp,LOCATION_DECK,0,1,nil,c:GetRace())
end
function c88123329.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88123329.rmfilter,tp,LOCATION_EXTRA,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c88123329.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c88123329.rmfilter,tp,LOCATION_EXTRA,0,1,1,nil,tp)
	if g:GetCount()>0 and Duel.Remove(g,POS_FACEUP,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(tp,c88123329.tgfilter,tp,LOCATION_DECK,0,1,1,nil,g:GetFirst():GetRace())
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
