--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 封魔一闪  (ID: 39956951)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方场上的怪兽卡区域全部有怪兽存在的场合才能发动。对方场上存在的全部怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--封魔一閃
function c39956951.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c39956951.condition)
	e1:SetTarget(c39956951.target)
	e1:SetOperation(c39956951.activate)
	c:RegisterEffect(e1)
end
function c39956951.cfilter(c)
	return c:GetSequence()<5
end
function c39956951.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c39956951.cfilter,tp,0,LOCATION_MZONE,nil)>=5
end
function c39956951.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c39956951.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
