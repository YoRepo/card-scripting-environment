--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 触发器冻结妖  (ID: 32176662)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Cyberse
-- Level 1
-- ATK 500 | DEF 500
--
-- Effect Text:
-- ①：这张卡被送去墓地的场合才能发动。对方场上的攻击表示怪兽全部变成守备表示。
--[[ __CARD_HEADER_END__ ]]

--フリップ・フローズン
function c32176662.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c32176662.postg)
	e1:SetOperation(c32176662.posop)
	c:RegisterEffect(e1)
end
function c32176662.filter(c)
	return c:IsAttackPos() and c:IsCanChangePosition()
end
function c32176662.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c32176662.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c32176662.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c32176662.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c32176662.filter,tp,0,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
end
