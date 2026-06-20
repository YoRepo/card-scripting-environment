--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 变形  (ID: 92890308)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的名字带有「变形斗士」的怪兽被选择作为攻击对象时才能发动。把1只攻击怪兽的攻击无效，被选择作为攻击对象的1只名字带有「变形斗士」的怪兽的表示形式改变。
--[[ __CARD_HEADER_END__ ]]

--ディフォーム
function c92890308.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c92890308.condition)
	e1:SetTarget(c92890308.target)
	e1:SetOperation(c92890308.activate)
	c:RegisterEffect(e1)
end
function c92890308.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d:IsControler(tp) and d:IsFaceup() and d:IsSetCard(0x26)
end
function c92890308.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ta=Duel.GetAttacker()
	local td=Duel.GetAttackTarget()
	if chkc then return chkc==ta end
	if chk==0 then return ta:IsOnField() and ta:IsCanBeEffectTarget(e)
		and td:IsOnField() and td:IsCanBeEffectTarget(e) end
	local g=Group.FromCards(ta,td)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,td,1,0,0)
end
function c92890308.activate(e,tp,eg,ep,ev,re,r,rp)
	local ta=Duel.GetAttacker()
	local td=Duel.GetAttackTarget()
	if ta:IsRelateToEffect(e) and Duel.NegateAttack() and td:IsFaceup() and td:IsRelateToEffect(e) then
		Duel.ChangePosition(td,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end
