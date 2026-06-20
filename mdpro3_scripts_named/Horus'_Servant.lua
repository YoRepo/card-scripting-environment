--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 荷鲁斯的仆人  (ID: 9264485)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 413
--
-- Effect Text:
-- 只要这张卡在自己场上表侧表示存在，对方的魔法·陷阱·怪兽的效果不能以「荷鲁斯之黑炎龙（包括全部等级）」的怪兽为对象。
--[[ __CARD_HEADER_END__ ]]

--ホルスのしもべ
function c9264485.initial_effect(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x119d))
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
end
