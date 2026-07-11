--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Labrynth Set-Up  (ID: 69895264)
-- Type: Spell / Quick-Play
-- Setcode: 0x17e
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 2 of your "Labrynth" Spells/Traps that are banished or in your GY, except "Labrynth Set-Up";
-- shuffle them into the Deck, then if you control a Fiend monster, you can Set non-"Labrynth" Normal
-- Traps with different names directly from your Deck equal to the number shuffled.
-- You can only activate 1 "Labrynth Set-Up" per turn.
--[[ __CARD_HEADER_END__ ]]

--ラビュリンス・セッティング
function c69895264.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,69895264+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c69895264.target)
	e1:SetOperation(c69895264.activate)
	c:RegisterEffect(e1)
end
function c69895264.tdfilter(c)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsType(TYPE_SPELL+TYPE_TRAP)
		and c:IsSetCard(0x17e) and not c:IsCode(69895264) and c:IsAbleToDeck()
end
function c69895264.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c69895264.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c69895264.tdfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c69895264.tdfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
end
function c69895264.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.SendtoDeck(tg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		local ct=tg:FilterCount(Card.IsLocation,nil,LOCATION_DECK)
		local sg=Duel.GetMatchingGroup(c69895264.stfilter,tp,LOCATION_DECK,0,nil)
		local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
		if ct>0 and Duel.IsExistingMatchingCard(c69895264.demfilter,tp,LOCATION_MZONE,0,1,nil)
			and sg:GetClassCount(Card.GetCode)>=ct and ft>=ct
			and Duel.SelectYesNo(tp,aux.Stringid(69895264,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
			local stg=sg:SelectSubGroup(tp,aux.dncheck,false,ct,ct)
			Duel.SSet(tp,stg)
		end
	end
end
function c69895264.demfilter(c)
	return c:IsRace(RACE_FIEND) and c:IsFaceup()
end
function c69895264.stfilter(c)
	return c:GetType()==TYPE_TRAP and not c:IsSetCard(0x17e) and c:IsSSetable()
end
