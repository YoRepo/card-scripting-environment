--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 星圣·毕星团  (ID: 47579719)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Rank 3
-- ATK 1900 | DEF 1100
-- Setcode: 83
--
-- Effect Text:
-- 光属性3星怪兽×2
-- 1回合1次，把这张卡1个超量素材取除才能发动。对方场上存在的怪兽全部变成表侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--セイクリッド・ヒアデス
function c47579719.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT),3,2)
	c:EnableReviveLimit()
	--pos change
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetDescription(aux.Stringid(47579719,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c47579719.cost)
	e1:SetTarget(c47579719.target)
	e1:SetOperation(c47579719.operation)
	c:RegisterEffect(e1)
end
function c47579719.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c47579719.filter(c)
	return not c:IsPosition(POS_FACEUP_DEFENSE) and c:IsCanChangePosition()
end
function c47579719.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c47579719.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c47579719.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c47579719.filter,tp,0,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE)
end
