--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 编码语者  (ID: 6622715)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Cyberse
-- ATK 2300 | LINK
-- Setcode: 257
--
-- Effect Text:
-- 电子界族怪兽2只以上
-- ①：1回合1次，这张卡所连接区的自己怪兽和比那只怪兽攻击力高的对方怪兽进行战斗的伤害计算前才能发动。那只自己怪兽不会被那次战斗破坏，那次战斗发生的对自己的战斗伤害变成0。那次伤害计算后，选这张卡或者这
-- 张卡所连接区1只自己怪兽，那个攻击力直到回合结束时上升那只进行战斗的对方怪兽的攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--エンコード・トーカー
function c6622715.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6622715,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c6622715.condition)
	e1:SetOperation(c6622715.operation)
	c:RegisterEffect(e1)
end
function c6622715.condition(e,tp,eg,ep,ev,re,r,rp)
	local lg=e:GetHandler():GetLinkedGroup()
	local a=Duel.GetAttacker()
	local b=a:GetBattleTarget()
	if not b then return false end
	if a:IsControler(1-tp) then a,b=b,a end
	return a:GetControler()~=b:GetControler()
		and lg:IsContains(a) and a:IsFaceup() and b:IsFaceup()
		and b:GetAttack()>a:GetAttack()
end
function c6622715.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local b=a:GetBattleTarget()
	if a:IsControler(1-tp) then a,b=b,a end
	if a:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		a:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_BATTLED)
	e3:SetLabelObject(b)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c6622715.atkop)
	e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
	c:RegisterEffect(e3)
end
function c6622715.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local b=e:GetLabelObject()
	local lg=c:GetLinkedGroup()
	lg:AddCard(c)
	local tc=nil
	if lg:GetCount()==1 then
		tc=lg:GetFirst()
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		tc=lg:Select(tp,1,1,nil):GetFirst()
	end
	Duel.HintSelection(Group.FromCards(tc))
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(b:GetAttack())
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
end
