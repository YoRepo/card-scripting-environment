--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 死之魔术箱  (ID: 25774450)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以自己以及对方场上的怪兽各1只为对象才能发动。那只对方怪兽破坏。那之后，那只自己怪兽的控制权移给对方。
--[[ __CARD_HEADER_END__ ]]

--死のマジック・ボックス
function c25774450.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c25774450.target)
	e1:SetOperation(c25774450.activate)
	c:RegisterEffect(e1)
end
function c25774450.filter(c,tp)
	return Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
end
function c25774450.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c25774450.filter,tp,0,LOCATION_MZONE,1,nil,1-tp)
		and Duel.IsExistingTarget(Card.IsAbleToChangeControler,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c25774450.filter,tp,0,LOCATION_MZONE,1,1,nil,1-tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g2=Duel.SelectTarget(tp,Card.IsAbleToChangeControler,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g2,1,0,0)
end
function c25774450.activate(e,tp,eg,ep,ev,re,r,rp)
	local ex1,dg=Duel.GetOperationInfo(0,CATEGORY_DESTROY)
	local ex2,cg=Duel.GetOperationInfo(0,CATEGORY_CONTROL)
	local dc=dg:GetFirst()
	local cc=cg:GetFirst()
	if dc:IsRelateToEffect(e) and Duel.Destroy(dc,REASON_EFFECT)~=0 then
		if cc:IsRelateToEffect(e) then
			Duel.BreakEffect()
			Duel.GetControl(cc,1-tp)
		end
	end
end
