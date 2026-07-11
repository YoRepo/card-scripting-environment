--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Asleep at the Switch  (ID: 99657399)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent gains Life Points: Target 1 monster your opponent controls; destroy that target.
--[[ __CARD_HEADER_END__ ]]

--油断大敵
function c99657399.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_RECOVER)
	e1:SetCondition(c99657399.condition)
	e1:SetTarget(c99657399.target)
	e1:SetOperation(c99657399.activate)
	c:RegisterEffect(e1)
end
function c99657399.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c99657399.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c99657399.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
