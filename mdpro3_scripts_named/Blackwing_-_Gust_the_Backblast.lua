--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 黑羽-逆风之加斯特  (ID: 52869807)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 2
-- ATK 900 | DEF 1400
-- Setcode: 51
--
-- Effect Text:
-- 自己场上没有卡存在的场合，这张卡可以从手卡特殊召唤。只要这张卡在场上表侧表示存在，对方怪兽向自己场上存在的名字带有「黑羽」的怪兽攻击的场合，那只攻击怪兽在伤害步骤内攻击力下降300。
--[[ __CARD_HEADER_END__ ]]

--BF－逆風のガスト
function c52869807.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c52869807.spcon)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c52869807.atkcon)
	e2:SetTarget(c52869807.atktg)
	e2:SetValue(-300)
	c:RegisterEffect(e2)
end
function c52869807.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.GetFieldGroupCount(c:GetControler(),LOCATION_ONFIELD,0)==0
end
function c52869807.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	local d=Duel.GetAttackTarget()
	local tp=e:GetHandlerPlayer()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
		and d and d:IsControler(tp) and d:IsSetCard(0x33)
end
function c52869807.atktg(e,c)
	return c==Duel.GetAttacker()
end
