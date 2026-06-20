--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 巨角猛犸  (ID: 59380081)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 5
-- ATK 2000 | DEF 1000
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，对方场上怪兽召唤·反转召唤·特殊召唤的回合不能攻击。
--[[ __CARD_HEADER_END__ ]]

--ビッグホーン・マンモス
function c59380081.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c59380081.target)
	c:RegisterEffect(e1)
end
function c59380081.target(e,c)
	return c:IsStatus(STATUS_SUMMON_TURN+STATUS_FLIP_SUMMON_TURN+STATUS_SPSUMMON_TURN)
end
