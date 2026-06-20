--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 光波干涉  (ID: 55496220)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 229
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：场上有同名怪兽存在的自己的「光波」怪兽进行战斗的伤害计算时才能发动。那只进行战斗的自己的「光波」怪兽的攻击力直到战斗阶段结束时变成2倍。
--[[ __CARD_HEADER_END__ ]]

--光波干渉
function c55496220.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(55496220,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,55496220)
	e2:SetCondition(c55496220.atkcon)
	e2:SetOperation(c55496220.atkop)
	c:RegisterEffect(e2)
end
function c55496220.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c55496220.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetBattleMonster(tp)
	if not tc then return false end
	e:SetLabelObject(tc)
	return tc:IsFaceup() and tc:IsSetCard(0xe5)
		and Duel.IsExistingMatchingCard(c55496220.cfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,tc,tc:GetCode())
end
function c55496220.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() and tc:IsControler(tp) and tc:IsFaceup() and tc:IsSetCard(0xe5) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
	end
end
