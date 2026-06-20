--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 业火之结界像  (ID: 47961808)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 4
-- ATK 1000 | DEF 1000
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，双方不是炎属性怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--業火の結界像
function c47961808.initial_effect(c)
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c47961808.sumlimit)
	c:RegisterEffect(e1)
end
function c47961808.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:GetAttribute()~=ATTRIBUTE_FIRE
end
