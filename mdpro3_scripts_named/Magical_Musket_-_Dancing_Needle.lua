--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Magical Musket - Dancing Needle  (ID: 66149377)
-- Type: Trap
-- Setcode: 0x108
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Magical Musket" monster: Target up to 3 cards in the GYs; banish them.
-- You can only activate 1 "Magical Musket - Dancing Needle" per turn.
--[[ __CARD_HEADER_END__ ]]

--魔弾－ダンシング・ニードル
function c66149377.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,66149377+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c66149377.condition)
	e1:SetTarget(c66149377.target)
	e1:SetOperation(c66149377.activate)
	c:RegisterEffect(e1)
end
function c66149377.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x108)
end
function c66149377.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c66149377.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c66149377.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),PLAYER_ALL,LOCATION_GRAVE)
end
function c66149377.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end
