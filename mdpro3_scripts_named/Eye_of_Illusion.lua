--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 幻惑之眼  (ID: 23446369)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己场上有幻想魔族或魔法师族的怪兽存在的场合，可以从以下效果选择1个发动。
-- ●这个回合中，自己的幻想魔族·魔法师族怪兽不会被战斗破坏。
-- ●对方回合，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽的控制权直到结束阶段得到。
-- ●对方怪兽的攻击宣言时，以攻击怪兽以外的对方场上1只表侧表示怪兽为对象才能发动。攻击对象转移为那只怪兽进行伤害计算。
--[[ __CARD_HEADER_END__ ]]

--幻惑の眼
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_ILLUSION+RACE_SPELLCASTER)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.tfilter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	if chkc then
		local f={false,s.tfilter(chkc),chkc:IsFaceup() and chkc~=a}
		return f[e:GetLabel()] and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp)
	end
	if chk==0 then return true end
	local b2=Duel.GetTurnPlayer()==1-tp
		and Duel.IsExistingTarget(s.tfilter,tp,0,LOCATION_MZONE,1,nil)
	local b3=Duel.GetTurnPlayer()==1-tp
		and Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE)
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,a)
	local op=aux.SelectFromOptions(tp,{true,aux.Stringid(id,1)},{b2,aux.Stringid(id,2)},{b3,aux.Stringid(id,3)})
	e:SetLabel(op)
	if op==1 then
		e:SetCategory(0)
		e:SetProperty(0)
	elseif op==2 then
		e:SetCategory(CATEGORY_CONTROL)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		local g=Duel.SelectTarget(tp,s.tfilter,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	else
		e:SetCategory(0)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,a)
	end
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local op=e:GetLabel()
	if op==1 then
		s.protect(e,tp,eg,ep,ev,re,r,rp)
	elseif op==2 then
		s.control(e,tp,eg,ep,ev,re,r,rp)
	elseif op==3 then
		s.tattack(e,tp,eg,ep,ev,re,r,rp)
	end
end
function s.protect(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_ILLUSION+RACE_SPELLCASTER))
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
end
function s.control(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then Duel.GetControl(tc,tp,PHASE_END,1) end
end
function s.tattack(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and a:IsAttackable() and not a:IsImmuneToEffect(e) then
		Duel.CalculateDamage(a,tc)
	end
end
