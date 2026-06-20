--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 升灵术师 奘玄  (ID: 41855169)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 3
-- ATK 200 | DEF 1300
--
-- Effect Text:
-- 把手卡随机1张丢弃去墓地才能发动。场上的特殊召唤的怪兽全部破坏。此外，只要这张卡在场上表侧表示存在，双方不能把怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--昇霊術師 ジョウゲン
function c41855169.initial_effect(c)
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41855169,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c41855169.cost)
	e2:SetTarget(c41855169.target)
	e2:SetOperation(c41855169.operation)
	c:RegisterEffect(e2)
end
function c41855169.cfilter(c)
	return c:IsDiscardable() and c:IsAbleToGraveAsCost() and not c:IsHasEffect(81674782)
end
function c41855169.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41855169.cfilter,tp,LOCATION_HAND,0,1,nil) end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local sg=g:RandomSelect(tp,1)
	Duel.SendtoGrave(sg,REASON_COST+REASON_DISCARD)
end
function c41855169.filter(c)
	return c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c41855169.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41855169.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c41855169.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c41855169.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c41855169.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
