--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Metabo-Shark  (ID: 37792478)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 4
-- ATK 1800 | DEF 500
-- Setcode: 0x1b8
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can target 2 Fish-Type monsters in your Graveyard; shuffle
-- those targets into your Deck.
--[[ __CARD_HEADER_END__ ]]

--メタボ・シャーク
function c37792478.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37792478,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c37792478.target)
	e1:SetOperation(c37792478.operation)
	c:RegisterEffect(e1)
end
function c37792478.filter(c)
	return c:IsRace(RACE_FISH) and c:IsAbleToDeck()
end
function c37792478.opfilter(c,e)
	return c:IsRelateToEffect(e) and c:IsRace(RACE_FISH)
end
function c37792478.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c37792478.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c37792478.filter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c37792478.filter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
end
function c37792478.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c37792478.opfilter,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
