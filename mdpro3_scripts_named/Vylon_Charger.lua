--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 大日充能者  (ID: 13220032)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1000 | DEF 1000
-- Setcode: 48
--
-- Effect Text:
-- 自己场上表侧表示存在的光属性怪兽的攻击力上升这张卡装备的装备卡数量×300的数值。
--[[ __CARD_HEADER_END__ ]]

--ヴァイロン・チャージャー
function c13220032.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT))
	e1:SetValue(c13220032.atkval)
	c:RegisterEffect(e1)
end
function c13220032.atkval(e,c)
	return e:GetHandler():GetEquipCount()*300
end
