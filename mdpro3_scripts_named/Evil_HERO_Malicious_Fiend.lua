--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 邪心英雄 恶刃魔鬼  (ID: 86676862)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Fiend
-- Level 8
-- ATK 3500 | DEF 2100
-- Setcode: 24584
--
-- Effect Text:
-- 「邪心英雄 恶刃魔」＋6星以上的恶魔族怪兽
-- 这张卡用「暗黑融合」的效果才能特殊召唤。
-- ①：只要这张卡在怪兽区域存在，对方战斗阶段内，对方场上的全部怪兽变成表侧攻击表示，并在可以攻击的场合必须向这张卡作出攻击。
--[[ __CARD_HEADER_END__ ]]

--E-HERO マリシャス・デビル
function c86676862.initial_effect(c)
	aux.AddCodeList(c,94820406)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,58554959,c86676862.ffilter,1,true,true)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.DarkFusionLimit)
	c:RegisterEffect(e2)
	--Pos Change
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_POSITION)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c86676862.poscon)
	e3:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e3)
	--must attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_MUST_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c86676862.poscon)
	e4:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	e5:SetValue(c86676862.atklimit)
	c:RegisterEffect(e5)
end
c86676862.material_setcode=0x8
c86676862.dark_calling=true
function c86676862.ffilter(c)
	return c:IsRace(RACE_FIEND) and c:IsLevelAbove(6)
end
function c86676862.poscon(e)
	return Duel.IsTurnPlayer(1-e:GetHandlerPlayer()) and Duel.IsBattlePhase()
end
function c86676862.atklimit(e,c)
	return c==e:GetHandler()
end
