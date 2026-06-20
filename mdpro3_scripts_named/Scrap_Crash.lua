--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 废铁崩溃  (ID: 5577649)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 36
--
-- Effect Text:
-- 自己场上存在的名字带有「废铁」的怪兽被破坏送去墓地时才能发动。场上表侧表示存在的魔法·陷阱卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--スクラップ・クラッシュ
function c5577649.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c5577649.condition)
	e1:SetTarget(c5577649.target)
	e1:SetOperation(c5577649.operation)
	c:RegisterEffect(e1)
end
function c5577649.cfilter(c,tp)
	return c:IsSetCard(0x24) and c:IsReason(REASON_DESTROY) and c:IsPreviousControler(tp)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP)
end
function c5577649.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c5577649.cfilter,1,nil,tp)
end
function c5577649.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c5577649.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c5577649.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c5577649.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c5577649.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c5577649.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,aux.ExceptThisCard(e))
	Duel.Destroy(g,REASON_EFFECT)
end
