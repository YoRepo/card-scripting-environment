--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Adamancipator Crystal - Leonite  (ID: 47897376)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Rock
-- Level: 4
-- ATK 0 | DEF 2200
-- Setcode: 0x140
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Special Summoned by the effect of an "Adamancipator" card: You can place 1
-- "Adamancipator" card from your hand or GY on top of the Deck.
-- If this card is in your GY: You can target 1 FIRE Synchro Monster you control or in your GY; return
-- it to the Extra Deck, and if you do, place this card on top of the Deck.
-- You can only use each effect of "Adamancipator Crystal - Leonite" once per turn.
--[[ __CARD_HEADER_END__ ]]

--魔救の奇石－レオナイト
function c47897376.initial_effect(c)
	--to decktop1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47897376,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,47897376)
	e1:SetCondition(c47897376.dtcon1)
	e1:SetTarget(c47897376.dttg1)
	e1:SetOperation(c47897376.dtop1)
	c:RegisterEffect(e1)
	--to decktop2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(47897376,1))
	e2:SetCategory(CATEGORY_TOEXTRA+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,47897377)
	e2:SetTarget(c47897376.dttg2)
	e2:SetOperation(c47897376.dtop2)
	c:RegisterEffect(e2)
end
function c47897376.dtcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSpecialSummonSetCard(0x140)
end
function c47897376.dtfilter(c)
	return c:IsSetCard(0x140) and c:IsAbleToDeck()
end
function c47897376.dttg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c47897376.dtfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c47897376.dtop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c47897376.dtfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if tc:IsLocation(LOCATION_HAND) then
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.HintSelection(g)
		end
		Duel.SendtoDeck(g,nil,SEQ_DECKTOP,REASON_EFFECT)
	end
end
function c47897376.texfilter(c)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsType(TYPE_SYNCHRO) and c:IsAbleToExtra()
end
function c47897376.dttg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and chkc:IsControler(tp) and c47897376.texfilter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c47897376.texfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,c) and c:IsAbleToDeck() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c47897376.texfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,c,1,0,0)
end
function c47897376.dtop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_EXTRA) and c:IsRelateToEffect(e) then
		Duel.SendtoDeck(c,nil,SEQ_DECKTOP,REASON_EFFECT)
	end
end
