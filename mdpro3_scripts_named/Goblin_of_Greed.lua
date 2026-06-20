--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 强欲哥布林  (ID: 425934)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level 4
-- ATK 1000 | DEF 1800
-- Setcode: 172
--
-- Effect Text:
-- 只要这张卡在自己场上以表侧表示存在，双方都不能发动「通过丢弃手卡来发动」的效果。
--[[ __CARD_HEADER_END__ ]]

--強欲ゴブリン
function c425934.initial_effect(c)
	--discard limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,1)
	e1:SetCode(EFFECT_CANNOT_DISCARD_HAND)
	e1:SetTarget(c425934.target)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c425934.target(e,dc,re,r)
	return r&REASON_COST==REASON_COST
end
