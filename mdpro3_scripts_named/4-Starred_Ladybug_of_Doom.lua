--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 死之四星瓢虫  (ID: 83994646)
-- Type: Monster / Effect / Toon
-- Attribute: WIND
-- Race: Insect
-- Level 3
-- ATK 800 | DEF 1200
--
-- Effect Text:
-- 反转：对方场上表侧表示存在的4星怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--死の4つ星てんとう虫
function c83994646.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83994646,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c83994646.target)
	e1:SetOperation(c83994646.operation)
	c:RegisterEffect(e1)
end
function c83994646.filter(c)
	return c:IsFaceup() and c:IsLevel(4)
end
function c83994646.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c83994646.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c83994646.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c83994646.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
