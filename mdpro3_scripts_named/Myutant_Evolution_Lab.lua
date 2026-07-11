--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Myutant Evolution Lab  (ID: 34572613)
-- Type: Spell / Field
-- Setcode: 0x157
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is activated: You can Special Summon 1 of your Level 4 or lower "Myutant" monsters
-- from your hand or that is banished. "Myutant" monsters you control gain 100 ATK for each of your
-- banished "Myutant" cards with different names.
-- Once per turn, during your Main Phase: You can place 1 "Myutant" monster from your hand on the
-- bottom of the Deck, and if you do, draw 1 card.
-- You can only activate 1 "Myutant Evolution Lab" per turn.
--[[ __CARD_HEADER_END__ ]]

--ミュートリア進化研究所
function c34572613.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,34572613+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c34572613.activate)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x157))
	e2:SetValue(c34572613.atkval)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34572613,1))
	e3:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c34572613.drtg)
	e3:SetOperation(c34572613.drop)
	c:RegisterEffect(e3)
end
function c34572613.spfilter(c,e,tp)
	return c:IsSetCard(0x157) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelBelow(4) and (c:IsFaceup() or c:IsLocation(LOCATION_HAND))
end
function c34572613.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMZoneCount(tp)<=0 then return end
	local g=Duel.GetMatchingGroup(c34572613.spfilter,tp,LOCATION_HAND+LOCATION_REMOVED,0,nil,e,tp)
	if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(34572613,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c34572613.atkvalfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x157)
end
function c34572613.atkval(e,c)
	local tp=e:GetHandler():GetControler()
	local g=Duel.GetMatchingGroup(c34572613.atkvalfilter,tp,LOCATION_REMOVED,0,nil)
	return g:GetClassCount(Card.GetCode)*100
end
function c34572613.drtgfilter(c)
	return c:IsAbleToDeck() and c:IsSetCard(0x157) and c:IsType(TYPE_MONSTER)
end
function c34572613.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsExistingMatchingCard(c34572613.drtgfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c34572613.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c34572613.drtgfilter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		if Duel.SendtoDeck(tc,nil,SEQ_DECKBOTTOM,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_DECK) then
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
