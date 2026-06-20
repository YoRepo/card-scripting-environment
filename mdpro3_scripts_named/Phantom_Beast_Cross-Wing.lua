--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 幻兽 十字翼鸟  (ID: 71181155)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level 4
-- ATK 1300 | DEF 1300
-- Setcode: 27
--
-- Effect Text:
-- 只要这张卡在墓地存在，场上的名字带有「幻兽」的怪兽的攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--幻獣クロスウィング
function c71181155.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1b))
	e1:SetValue(300)
	c:RegisterEffect(e1)
end
