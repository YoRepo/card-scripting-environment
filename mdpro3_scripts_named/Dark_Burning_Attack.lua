--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 黑·魔·导·爆·裂·破  (ID: 49702428)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己场上有「黑魔术少女」怪兽存在的场合才能发动。对方场上的表侧表示怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--黒・魔・導・爆・裂・破
function c49702428.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c49702428.condition)
	e1:SetTarget(c49702428.target)
	e1:SetOperation(c49702428.activate)
	c:RegisterEffect(e1)
end
function c49702428.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x30a2)
end
function c49702428.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c49702428.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c49702428.filter(c)
	return c:IsFaceup()
end
function c49702428.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c49702428.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c49702428.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c49702428.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c49702428.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
