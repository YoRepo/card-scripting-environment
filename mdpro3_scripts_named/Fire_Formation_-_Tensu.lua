--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 炎舞-「天枢」  (ID: 10719350)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 124
--
-- Effect Text:
-- ①：只要这张卡在魔法与陷阱区域存在，自己在通常召唤外加上只有1次，自己主要阶段可以把1只兽战士族怪兽召唤。
-- ②：只要这张卡在魔法与陷阱区域存在，自己场上的兽战士族怪兽的攻击力上升100。
--[[ __CARD_HEADER_END__ ]]

--炎舞－「天枢」
function c10719350.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10719350,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_BEASTWARRIOR))
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_BEASTWARRIOR))
	e3:SetValue(100)
	c:RegisterEffect(e3)
end
