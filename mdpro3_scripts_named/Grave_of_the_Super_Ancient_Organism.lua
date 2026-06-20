--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 超古代生物的墓场  (ID: 83266092)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：只要这张卡在魔法与陷阱区域存在，特殊召唤的6星以上的怪兽不能攻击宣言，双方不能把那些效果发动。
--[[ __CARD_HEADER_END__ ]]

--超古代生物の墓場
function c83266092.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x28)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c83266092.target)
	c:RegisterEffect(e2)
	--cannot trigger
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_TRIGGER)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c83266092.target)
	c:RegisterEffect(e3)
end
function c83266092.target(e,c)
	return c:IsLevelAbove(6) and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
