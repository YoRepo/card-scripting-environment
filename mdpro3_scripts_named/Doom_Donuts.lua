--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 死亡甜甜圈  (ID: 10389794)
-- Type: Monster / Effect / Toon
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 反转：场上表侧表示存在的原本攻击力或者原本守备力是0的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--デス・ドーナツ
function c10389794.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10389794,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c10389794.target)
	e1:SetOperation(c10389794.operation)
	c:RegisterEffect(e1)
end
function c10389794.filter(c)
	return c:IsFaceup() and (c:GetBaseAttack()==0 or (c:GetBaseDefense()==0 and c:IsDefenseAbove(0)))
end
function c10389794.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c10389794.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c10389794.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c10389794.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
