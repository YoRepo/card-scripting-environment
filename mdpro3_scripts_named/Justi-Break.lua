--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 正义雷破  (ID: 62271284)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上的通常怪兽为攻击对象的对方怪兽的攻击宣言时才能发动。表侧攻击表示存在的通常怪兽以外的场上的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--ジャスティブレイク
function c62271284.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c62271284.condition)
	e1:SetTarget(c62271284.target)
	e1:SetOperation(c62271284.activate)
	c:RegisterEffect(e1)
end
function c62271284.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return tp~=Duel.GetTurnPlayer() and at and at:IsFaceup() and at:IsType(TYPE_NORMAL)
end
function c62271284.filter(c)
	return not (c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsAttackPos())
end
function c62271284.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c62271284.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c62271284.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c62271284.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c62271284.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
