--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 诱饵机人  (ID: 25034083)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 2
-- ATK 300 | DEF 500
-- Setcode: 22
--
-- Effect Text:
-- 只要这张卡在自己场上表侧表示存在，对方不能选择「诱饵机人」以外的表侧表示怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--デコイロイド
function c25034083.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetValue(c25034083.atlimit)
	c:RegisterEffect(e1)
end
function c25034083.atlimit(e,c)
	return not c:IsCode(25034083) and c:IsFaceup()
end
