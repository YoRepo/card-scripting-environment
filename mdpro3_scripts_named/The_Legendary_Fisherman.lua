--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 传说的渔人  (ID: 3643300)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level 5
-- ATK 1850 | DEF 1600
--
-- Effect Text:
-- ①：只要场上有「海」存在，场上的这张卡不受魔法卡的效果影响。
-- ②：只要场上有「海」存在，这张卡不会被作为攻击对象（自己场上只有被这个效果适用的怪兽存在的状态中对方的攻击变成对自己的直接攻击）。
--[[ __CARD_HEADER_END__ ]]

--伝説のフィッシャーマン
function c3643300.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--immune spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c3643300.econ)
	e1:SetValue(c3643300.efilter)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c3643300.econ)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c3643300.econ(e)
	return Duel.IsEnvironment(22702055)
end
function c3643300.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
