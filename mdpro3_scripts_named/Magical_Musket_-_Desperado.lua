--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Magical Musket - Desperado  (ID: 20745268)
-- Type: Trap
-- Setcode: 0x108
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Magical Musket" monster: Target 1 face-up card on the field; destroy it.
-- You can only activate 1 "Magical Musket - Desperado" per turn.
--[[ __CARD_HEADER_END__ ]]

--魔弾－デスペラード
function c20745268.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,20745268+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c20745268.condition)
	e1:SetTarget(c20745268.target)
	e1:SetOperation(c20745268.activate)
	c:RegisterEffect(e1)
end
function c20745268.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x108)
end
function c20745268.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c20745268.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c20745268.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and chkc:IsFaceup() and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c20745268.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
