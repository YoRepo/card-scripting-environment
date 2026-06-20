--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 幻奏的音女 丝可尔  (ID: 41767843)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 2
-- ATK 200 | DEF 200
-- Setcode: 155
--
-- Effect Text:
-- ①：自己的「幻奏」怪兽和对方怪兽进行战斗的伤害计算时，把这张卡从手卡送去墓地才能发动。那只对方怪兽的攻击力·守备力直到回合结束时变成0。
--[[ __CARD_HEADER_END__ ]]

--幻奏の音女スコア
function c41767843.initial_effect(c)
	--atkdef 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41767843,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c41767843.condition)
	e1:SetCost(c41767843.cost)
	e1:SetOperation(c41767843.operation)
	c:RegisterEffect(e1)
end
function c41767843.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if a:IsControler(1-tp) then a,d=d,a end
	return a:IsSetCard(0x9b) and a:IsRelateToBattle() and (d:GetAttack()>0 or d:GetDefense()>0)
end
function c41767843.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c41767843.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsControler(1-tp) then d=a end
	if not d:IsRelateToBattle() or d:IsFacedown() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(0)
	d:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	d:RegisterEffect(e2)
end
