--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 独角兽使魔  (ID: 22318971)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Beast
-- Level 2
-- ATK 0 | DEF 1000
--
-- Effect Text:
-- 表侧守备表示存在的这张卡被选择作为攻击对象时，可以把这张卡以外的自己场上存在的1只怪兽从游戏中除外，把这张卡从游戏中除外。那个时候的攻击怪兽必须作出攻击。这个效果除外的这张卡在下次的自己的准备阶段时回
-- 到场上。
--[[ __CARD_HEADER_END__ ]]

--一角獣の使い魔
function c22318971.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22318971,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c22318971.condition)
	e1:SetCost(c22318971.cost)
	e1:SetTarget(c22318971.target)
	e1:SetOperation(c22318971.operation)
	c:RegisterEffect(e1)
end
function c22318971.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE)
end
function c22318971.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c22318971.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() end
	Duel.SetTargetCard(Duel.GetAttacker())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
end
function c22318971.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and Duel.Remove(c,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		e1:SetCountLimit(1)
		e1:SetCondition(c22318971.retcon)
		e1:SetOperation(c22318971.retop)
		Duel.RegisterEffect(e1,tp)
		local ac=Duel.GetFirstTarget()
		if ac:IsRelateToEffect(e) and ac:IsFaceup() then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_MUST_ATTACK)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			ac:RegisterEffect(e2)
		end
	end
end
function c22318971.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c22318971.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetOwner())
end
