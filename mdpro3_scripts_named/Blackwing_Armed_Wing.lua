--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 黑羽-兵翼鸦  (ID: 76913983)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Winged Beast
-- Level 6
-- ATK 2300 | DEF 1000
-- Setcode: 51
--
-- Effect Text:
-- 「黑羽」调整＋调整以外的怪兽1只以上
-- ①：这张卡向守备表示怪兽攻击的伤害步骤内，这张卡的攻击力上升500。
-- ②：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--BF－アームズ・ウィング
function c76913983.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x33),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c76913983.atkcon)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c76913983.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	if ph~=PHASE_DAMAGE and ph~=PHASE_DAMAGE_CAL then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return e:GetHandler()==a and d and d:IsDefensePos()
end
