--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 幻灵草  (ID: 41249545)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Plant
-- Level 3
-- ATK 1000 | DEF 1000
--
-- Effect Text:
-- 这张卡的攻击力上升自己墓地存在的「幻灵草」的数量×500的数值。
--[[ __CARD_HEADER_END__ ]]

--グラスファントム
function c41249545.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c41249545.atkup)
	c:RegisterEffect(e1)
end
function c41249545.atkup(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,0,nil,41249545)*500
end
