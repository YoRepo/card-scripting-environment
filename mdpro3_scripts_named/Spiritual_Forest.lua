--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 神圣森林  (ID: 69112325)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 58
--
-- Effect Text:
-- 自己场上表侧表示存在的植物族·兽族·兽战士族怪兽1回合只有1次不会被战斗破坏。这个效果1回合只能适用1次。
--[[ __CARD_HEADER_END__ ]]

--神聖なる森
function c69112325.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c69112325.indtg)
	e2:SetCountLimit(1)
	e2:SetValue(c69112325.valcon)
	c:RegisterEffect(e2)
end
function c69112325.indtg(e,c)
	return c:IsRace(RACE_PLANT+RACE_BEAST+RACE_BEASTWARRIOR)
end
function c69112325.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
