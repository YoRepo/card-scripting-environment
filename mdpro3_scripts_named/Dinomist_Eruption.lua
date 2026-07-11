--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Dinomist Eruption  (ID: 74582050)
-- Type: Trap
-- Setcode: 0xd8
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a "Dinomist" monster(s) you control is destroyed by battle or card effect: Target 1 card your
-- opponent controls; destroy it.
--[[ __CARD_HEADER_END__ ]]

--ダイナミスト・エラプション
function c74582050.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c74582050.condition)
	e1:SetTarget(c74582050.target)
	e1:SetOperation(c74582050.activate)
	c:RegisterEffect(e1)
end
function c74582050.cfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousSetCard(0xd8) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c74582050.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c74582050.cfilter,1,nil,tp)
end
function c74582050.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c74582050.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
