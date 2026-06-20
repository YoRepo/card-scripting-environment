--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 疾行机人 弹珠机器  (ID: 96708940)
-- Type: Monster / Effect / Pendulum
-- Attribute: WIND
-- Race: Machine
-- Level 2
-- Pendulum Scales: L1 / R1
-- ATK 200 | DEF 100
-- Setcode: 8214
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：1回合1次，自己的守备表示怪兽被选择作为攻击对象时才能发动。那只怪兽变成表侧攻击表示。这个回合，那只怪兽不会被战斗破坏。
-- 【怪兽效果】
-- 这个卡名的怪兽效果1回合只能使用1次。
-- ①：这张卡召唤成功时才能发动。从卡组把1只「疾行机人」怪兽加入手卡。这个效果的发动后，直到回合结束时自己不是风属性怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--SRビーダマシーン
function c96708940.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--on attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c96708940.condition)
	e1:SetTarget(c96708940.target)
	e1:SetOperation(c96708940.opetation)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(96708940,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,96708940)
	e2:SetTarget(c96708940.thtg)
	e2:SetOperation(c96708940.thop)
	c:RegisterEffect(e2)
end
function c96708940.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at and at:IsControler(tp) and at:IsPosition(POS_DEFENSE)
end
function c96708940.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.GetAttackTarget():CreateEffectRelation(e)
end
function c96708940.opetation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local at=Duel.GetAttackTarget()
	if at:IsRelateToEffect(e) then
		Duel.ChangePosition(at,POS_FACEUP_ATTACK)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		at:RegisterEffect(e1)
	end
end
function c96708940.thfilter(c)
	return c:IsSetCard(0x2016) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c96708940.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c96708940.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c96708940.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c96708940.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c96708940.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c96708940.splimit(e,c,tp,sumtp,sumpos)
	return c:GetAttribute()~=ATTRIBUTE_WIND
end
