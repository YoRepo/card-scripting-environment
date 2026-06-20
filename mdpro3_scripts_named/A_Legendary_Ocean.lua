--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 传说之都 亚特兰蒂斯  (ID: 295517)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名在规则上当作「海」使用。
-- ①：场上的水属性怪兽的攻击力·守备力上升200。
-- ②：只要这张卡在场地区域存在，双方的手卡·场上的水属性怪兽的等级下降1星。
--[[ __CARD_HEADER_END__ ]]

--伝説の都 アトランティス
function c295517.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_LEVEL)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,LOCATION_HAND+LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER))
	e2:SetValue(-1)
	c:RegisterEffect(e2)
	--Atk
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetValue(200)
	c:RegisterEffect(e3)
	--Def
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
end
