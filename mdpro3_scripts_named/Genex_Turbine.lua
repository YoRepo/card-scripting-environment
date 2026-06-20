--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 次世代涡轮机  (ID: 52222372)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1400 | DEF 1300
-- Setcode: 2
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，自己场上的「次世代」怪兽的攻击力上升400。
--[[ __CARD_HEADER_END__ ]]

--タービン・ジェネクス
function c52222372.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x2))
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
