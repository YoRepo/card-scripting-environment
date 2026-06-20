--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 仪式之槛  (ID: 25796442)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：只要这张卡在魔法与陷阱区域存在，自己的仪式怪兽的战斗发生的对自己的战斗伤害变成0。
-- ②：只要这张卡在魔法与陷阱区域存在，自己场上的仪式怪兽不会成为怪兽的效果的对象，不会被怪兽的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--儀式の檻
function c25796442.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_RITUAL))
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetValue(c25796442.tgval)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetValue(c25796442.efilter)
	c:RegisterEffect(e4)
end
function c25796442.tgval(e,re,rp)
	return re:IsActiveType(TYPE_EFFECT)
end
function c25796442.efilter(e,re)
	return re:IsActiveType(TYPE_EFFECT)
end
