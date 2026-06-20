--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 盾翼怪鸟  (ID: 28859794)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 2
-- ATK 0 | DEF 900
--
-- Effect Text:
-- 这张卡1回合最多2次不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--シールド・ウィング
function c28859794.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(2)
	e1:SetValue(c28859794.valcon)
	c:RegisterEffect(e1)
end
function c28859794.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
