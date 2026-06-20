--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 豪雨之结界像  (ID: 10963799)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 4
-- ATK 1000 | DEF 1000
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，双方不能把水属性以外的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--豪雨の結界像
function c10963799.initial_effect(c)
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c10963799.sumlimit)
	c:RegisterEffect(e1)
end
function c10963799.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:GetAttribute()~=ATTRIBUTE_WATER
end
