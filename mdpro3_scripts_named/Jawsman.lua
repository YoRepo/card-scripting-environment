--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 鲛颚人  (ID: 50532786)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Beast-Warrior
-- Level 6
-- ATK 2600 | DEF 1600
--
-- Effect Text:
-- 这张卡不能特殊召唤。这张卡上级召唤的场合，解放的怪兽必须是水属性怪兽。这张卡的攻击力上升这张卡以外的自己场上表侧表示存在的水属性怪兽每1只300。
--[[ __CARD_HEADER_END__ ]]

--ジョーズマン
function c50532786.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--tribute limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRIBUTE_LIMIT)
	e2:SetValue(c50532786.tlimit)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c50532786.atkup)
	c:RegisterEffect(e3)
end
function c50532786.tlimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_WATER)
end
function c50532786.atkfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c50532786.atkup(e,c)
	return Duel.GetMatchingGroupCount(c50532786.atkfilter,c:GetControler(),LOCATION_MZONE,0,c)*300
end
