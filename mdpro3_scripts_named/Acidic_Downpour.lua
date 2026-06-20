--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 酸雨  (ID: 35956022)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 全部地属性怪兽的攻击力下降500，守备力上升400。
--[[ __CARD_HEADER_END__ ]]

--アシッドレイン
function c35956022.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_EARTH))
	e2:SetValue(-500)
	c:RegisterEffect(e2)
	--Def down
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(400)
	c:RegisterEffect(e3)
end
