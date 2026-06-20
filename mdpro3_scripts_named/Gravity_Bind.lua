--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 超重力网  (ID: 85742772)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 场上的4星以上的怪兽不能攻击。
--[[ __CARD_HEADER_END__ ]]

--グラヴィティ・バインド－超重力の網－
function c85742772.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c85742772.atktarget)
	c:RegisterEffect(e2)
end
function c85742772.atktarget(e,c)
	return c:IsLevelAbove(4)
end
