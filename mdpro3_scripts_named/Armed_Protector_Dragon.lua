--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 武装神龙 护甲龙  (ID: 29330706)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 8
-- ATK 2000 | DEF 2800
--
-- Effect Text:
-- ①：这张卡的攻击力上升这张卡装备的装备卡数量×500。
-- ②：只要这张卡在怪兽区域存在，自己场上的表侧表示的装备卡不会被效果破坏。
--[[ __CARD_HEADER_END__ ]]

--武装神竜プロテクト・ドラゴン
function c29330706.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_SZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_EQUIP))
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c29330706.val)
	c:RegisterEffect(e2)
end
function c29330706.val(e,c)
	return c:GetEquipCount()*500
end
