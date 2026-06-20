--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 怨灵的湿地带  (ID: 95220856)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 全场怪兽召唤·反转召唤·特殊召唤的那个回合不能攻击。
--[[ __CARD_HEADER_END__ ]]

--怨霊の湿地帯
function c95220856.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attack res
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c95220856.target)
	c:RegisterEffect(e2)
end
function c95220856.target(e,c)
	return c:IsStatus(STATUS_SUMMON_TURN+STATUS_FLIP_SUMMON_TURN+STATUS_SPSUMMON_TURN)
end
