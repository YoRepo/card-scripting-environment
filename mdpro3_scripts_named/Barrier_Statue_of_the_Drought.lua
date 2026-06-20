--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 干旱之结界像  (ID: 19740112)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 4
-- ATK 1000 | DEF 1000
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，双方不是地属性怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--干ばつの結界像
function c19740112.initial_effect(c)
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c19740112.sumlimit)
	c:RegisterEffect(e1)
end
function c19740112.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:GetAttribute()~=ATTRIBUTE_EARTH
end
