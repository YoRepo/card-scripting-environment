--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 勇猛眼灵摆龙  (ID: 88305705)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 2000
-- Setcode: 4338
--
-- Effect Text:
-- 「灵摆龙」怪兽＋战士族怪兽
-- ①：这张卡融合召唤成功时才能发动。对方场上的全部怪兽的攻击力变成0。这个回合，这张卡以外的自己怪兽不能攻击。
-- ②：只要这张卡在怪兽区域存在，攻击力0的怪兽发动的效果无效化。
-- ③：这张卡的攻击没让对方怪兽被破坏的伤害步骤结束时才能发动。那只对方怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--ブレイブアイズ・ペンデュラム・ドラゴン
function c88305705.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x10f2),aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),true)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88305705,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c88305705.atkcon)
	e1:SetTarget(c88305705.atktg)
	e1:SetOperation(c88305705.atkop)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c88305705.discon)
	e2:SetOperation(c88305705.disop)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88305705,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetCondition(c88305705.rmcon)
	e3:SetTarget(c88305705.rmtg)
	e3:SetOperation(c88305705.rmop)
	c:RegisterEffect(e3)
end
function c88305705.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c88305705.atkfilter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c88305705.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88305705.atkfilter,tp,0,LOCATION_MZONE,1,nil) end
end
function c88305705.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c88305705.atkfilter,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c88305705.ftarget)
	e2:SetLabel(c:GetFieldID())
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c88305705.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c88305705.discon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	local atk=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_ATTACK)
	return re:IsActiveType(TYPE_MONSTER) and atk==0
end
function c88305705.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
function c88305705.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	e:SetLabelObject(bc)
	return aux.dsercon(e,tp,eg,ep,ev,re,r,rp) and c==Duel.GetAttacker() and c:IsStatus(STATUS_OPPO_BATTLE)
		and bc and bc:IsOnField() and bc:IsRelateToBattle()
end
function c88305705.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetLabelObject():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end
function c88305705.rmop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() and bc:IsControler(1-tp) then
		Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end
