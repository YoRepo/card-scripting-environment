--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 漏电  (ID: 75967082)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上名字带有「电池人」的怪兽有3只以上表侧表示存在的场合才能发动。对方场上存在的卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--漏電
function c75967082.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c75967082.condition)
	e1:SetTarget(c75967082.target)
	e1:SetOperation(c75967082.activate)
	c:RegisterEffect(e1)
end
function c75967082.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x28)
end
function c75967082.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c75967082.cfilter,tp,LOCATION_MZONE,0,3,nil)
end
function c75967082.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c75967082.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
