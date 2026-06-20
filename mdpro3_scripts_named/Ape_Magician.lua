--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 魔法师猿  (ID: 31975743)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level 3
-- ATK 800 | DEF 1200
--
-- Effect Text:
-- 这张卡不能特殊召唤。这张卡在场上表侧攻击表示存在的场合，1回合1次，把手卡1只怪兽送去墓地，选择对方场上表侧守备表示存在的1只怪兽才能发动。直到这个回合的结束阶段时，得到选择的怪兽的控制权。这个效果得
-- 到控制权的怪兽在这个回合不能把表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--マジシャンズ・エイプ
function c31975743.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--control
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(31975743,0))
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c31975743.condition)
	e2:SetCost(c31975743.cost)
	e2:SetTarget(c31975743.target)
	e2:SetOperation(c31975743.operation)
	c:RegisterEffect(e2)
end
function c31975743.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c31975743.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c31975743.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c31975743.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c31975743.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c31975743.filter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsControlerCanBeChanged()
end
function c31975743.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c31975743.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c31975743.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c31975743.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c31975743.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.GetControl(tc,tp,PHASE_END,1)~=0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
			e1:SetReset(RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
		end
	end
end
