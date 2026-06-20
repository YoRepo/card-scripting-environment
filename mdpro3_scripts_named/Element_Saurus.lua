--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 元素恐龙  (ID: 92755808)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dinosaur
-- Level 4
-- ATK 1500 | DEF 1200
--
-- Effect Text:
-- 这只怪兽在场上有特定属性的怪兽存在的场合，得到以下的效果。
-- ●炎属性：这张卡攻击力上升500。
-- ●地属性：这张卡战斗破坏的怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--エレメント・ザウルス
function c92755808.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetCondition(c92755808.atkcon)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c92755808.discon)
	e2:SetOperation(c92755808.disop)
	c:RegisterEffect(e2)
end
function c92755808.filter(c,att)
	return c:IsFaceup() and c:IsAttribute(att)
end
function c92755808.atkcon(e)
	return Duel.IsExistingMatchingCard(c92755808.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_FIRE)
end
function c92755808.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
		and Duel.IsExistingMatchingCard(c92755808.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_EARTH)
end
function c92755808.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x17a0000)
	bc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_EVENT+0x17a0000)
	bc:RegisterEffect(e2)
end
