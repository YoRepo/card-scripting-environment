--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 小奇美拉  (ID: 68658728)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast
-- Level 2
-- ATK 600 | DEF 550
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，场上的炎属性怪兽的攻击力上升500，水属性怪兽的攻击力下降400。
--[[ __CARD_HEADER_END__ ]]

--リトル・キメラ
function c68658728.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(c68658728.tg1)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetTarget(c68658728.tg2)
	e2:SetValue(-400)
	c:RegisterEffect(e2)
end
function c68658728.tg1(e,c)
	return c:IsAttribute(ATTRIBUTE_FIRE)
end
function c68658728.tg2(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end
