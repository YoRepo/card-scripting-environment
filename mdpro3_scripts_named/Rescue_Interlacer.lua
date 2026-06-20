--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 救援隔行人  (ID: 63009228)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level 3
-- ATK 1000 | DEF 1200
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己的电子界族怪兽被攻击的伤害计算时把这张卡从手卡丢弃才能发动。那次战斗发生的对自己的战斗伤害变成0。
-- ②：这张卡为这张卡的效果发动而被丢弃去墓地的回合的结束阶段发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--レスキュー・インターレーサー
function c63009228.initial_effect(c)
	--Damage to 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63009228,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,63009228)
	e1:SetCondition(c63009228.dmcon)
	e1:SetCost(c63009228.dmcost)
	e1:SetOperation(c63009228.dmop)
	c:RegisterEffect(e1)
	--revive
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(63009228,1))
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetCondition(c63009228.sumcon)
	e2:SetTarget(c63009228.sumtg)
	e2:SetOperation(c63009228.sumop)
	c:RegisterEffect(e2)
end
function c63009228.dmcon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsRace(RACE_CYBERSE) and Duel.GetBattleDamage(tp)>0
end
function c63009228.dmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
	c:RegisterFlagEffect(63009228,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c63009228.dmop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c63009228.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(63009228)>0
end
function c63009228.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c63009228.sumop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
