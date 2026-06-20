--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 等级限制B地区  (ID: 3136426)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 场上的4星以上的怪兽变成守备表示。
--[[ __CARD_HEADER_END__ ]]

--レベル制限B地区
function c3136426.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Pos Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_POSITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c3136426.target)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(POS_FACEUP_DEFENSE)
	c:RegisterEffect(e2)
end
function c3136426.target(e,c)
	return c:IsLevelAbove(4) and c:IsFaceup()
end
