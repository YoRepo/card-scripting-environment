--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 电池人-单一型  (ID: 55401221)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 1
-- ATK 0 | DEF 1900
-- Setcode: 40
--
-- Effect Text:
-- 只要这张卡在自己场上表侧表示存在，对方不能选择自己场上存在的「电池人-单一型」以外的雷族怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--電池メン－単一型
function c55401221.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c55401221.atlimit)
	c:RegisterEffect(e1)
end
function c55401221.atlimit(e,c)
	return c:IsFaceup() and c:IsRace(RACE_THUNDER) and not c:IsCode(55401221)
end
