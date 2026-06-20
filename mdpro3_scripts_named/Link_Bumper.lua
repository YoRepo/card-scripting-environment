--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 连接缓冲人  (ID: 67231737)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Cyberse
-- ATK 1400 | LINK
--
-- Effect Text:
-- 电子界族怪兽2只
-- ①：1回合1次，这张卡所连接区的自己怪兽向对方的连接怪兽攻击的伤害步骤结束时才能发动。这次战斗阶段中，那只怪兽在通常攻击外加上可以向对方的连接怪兽作出最多有这张卡以外的自己场上的连接怪兽数量的攻击。这
-- 个效果发动的回合，那只怪兽以外的自己怪兽不能攻击。
--[[ __CARD_HEADER_END__ ]]

--リンク・バンパー
function c67231737.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2,2)
	--extra attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67231737,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c67231737.condition)
	e1:SetCost(c67231737.cost)
	e1:SetTarget(c67231737.target)
	e1:SetOperation(c67231737.operation)
	c:RegisterEffect(e1)
end
function c67231737.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a:IsControler(1-tp) then return false end
	local lg=e:GetHandler():GetLinkedGroup()
	local d=a:GetBattleTarget()
	return lg:IsContains(a) and d and d:IsControler(1-tp)
end
function c67231737.oathfilter(c)
	return c:GetAttackAnnouncedCount()>0
end
function c67231737.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local c=e:GetHandler()
	if chk==0 then return not Duel.IsExistingMatchingCard(c67231737.oathfilter,tp,LOCATION_MZONE,0,1,a) end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c67231737.ftarget)
	e1:SetLabel(a:GetFieldID())
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c67231737.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c67231737.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_MZONE,0,e:GetHandler(),TYPE_LINK)>0 end
end
function c67231737.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local gc=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_MZONE,0,aux.ExceptThisCard(e),TYPE_LINK)
	if gc==0 then return end
	local a=Duel.GetAttacker()
	if a:IsRelateToBattle() and a:IsFaceup() then
		local e0=Effect.CreateEffect(c)
		e0:SetType(EFFECT_TYPE_SINGLE)
		e0:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e0:SetValue(gc)
		e0:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		a:RegisterEffect(e0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
		e1:SetValue(c67231737.atklimit)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		a:RegisterEffect(e1)
	end
end
function c67231737.atklimit(e,c)
	return not c:IsType(TYPE_LINK)
end
