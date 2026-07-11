--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Karakuri Trick House  (ID: 33184236)
-- Type: Trap
-- Setcode: 0x11
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when the battle position of a face-up "Karakuri" monster you control is changed.
-- Select 1 card on the field, and destroy it.
--[[ __CARD_HEADER_END__ ]]

--カラクリ屋敷
function c33184236.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCondition(c33184236.condition)
	e1:SetTarget(c33184236.target)
	e1:SetOperation(c33184236.activate)
	c:RegisterEffect(e1)
end
function c33184236.cfilter(c,tp)
	local np=c:GetPosition()
	local pp=c:GetPreviousPosition()
	return c:IsControler(tp) and c:IsSetCard(0x11) and ((pp==0x1 and np==0x4) or (pp==0x4 and np==0x1))
end
function c33184236.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c33184236.cfilter,1,nil,tp)
end
function c33184236.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c33184236.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
