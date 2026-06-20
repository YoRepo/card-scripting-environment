--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 宝石骑士·橙黄晶  (ID: 67985943)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Pyro
-- Level 7
-- ATK 2200 | DEF 1950
-- Setcode: 4167
--
-- Effect Text:
-- 「宝石骑士」怪兽＋炎族怪兽
-- 这张卡用融合召唤才能从额外卡组特殊召唤。
-- ①：这张卡进行战斗的场合，对方直到伤害步骤结束时魔法·陷阱·怪兽的效果不能发动。
--[[ __CARD_HEADER_END__ ]]

--ジェムナイト・マディラ
function c67985943.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1047),aux.FilterBoolFunction(Card.IsRace,RACE_PYRO),true)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(c67985943.splimit)
	c:RegisterEffect(e2)
	--actlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	e3:SetValue(1)
	e3:SetCondition(c67985943.actcon)
	c:RegisterEffect(e3)
end
function c67985943.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c67985943.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
