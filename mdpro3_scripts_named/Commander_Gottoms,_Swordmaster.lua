--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 总剑司令 加特姆士  (ID: 53388413)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 6
-- ATK 2100 | DEF 1600
-- Setcode: 176
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，自己场上表侧表示存在的名字带有「剑士」的怪兽的攻击力上升400。
--[[ __CARD_HEADER_END__ ]]

--総剣司令 ガトムズ
function c53388413.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xd))
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
