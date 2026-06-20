--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 等级限制A地区  (ID: 54976796)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 场上表侧表示存在的3星以下怪兽全部变成攻击表示。
--[[ __CARD_HEADER_END__ ]]

--レベル制限A地区
function c54976796.initial_effect(c)
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
	e2:SetTarget(c54976796.target)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e2)
end
function c54976796.target(e,c)
	return c:IsLevelBelow(3) and c:IsFaceup()
end
