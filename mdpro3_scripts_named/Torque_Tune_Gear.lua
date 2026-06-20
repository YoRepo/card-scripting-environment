--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 扭力调整齿轮  (ID: 79538761)
-- Type: Monster / Effect / Union / Tuner
-- Attribute: LIGHT
-- Race: Machine
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：1回合1次，可以从以下效果选择1个发动。
-- ●以自己场上1只表侧表示怪兽为对象，把这张卡当作装备卡使用给那只怪兽装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备的这张卡特殊召唤。
-- ②：装备怪兽的攻击力·守备力上升500，当作调整使用。
--[[ __CARD_HEADER_END__ ]]

--トルクチューン・ギア
function c79538761.initial_effect(c)
	aux.EnableUnionAttribute(c,aux.TRUE)
	--add type
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_ADD_TYPE)
	e4:SetValue(TYPE_TUNER)
	c:RegisterEffect(e4)
	--atkup
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(500)
	c:RegisterEffect(e5)
	--defup
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_UPDATE_DEFENSE)
	e6:SetValue(500)
	c:RegisterEffect(e6)
end
