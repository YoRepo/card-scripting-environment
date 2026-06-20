--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 曾被称为神的龟  (ID: 74952447)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 1
-- ATK 0 | DEF 1800
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，双方不能把攻击力1800以上的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--かつて神と呼ばれた亀
function c74952447.initial_effect(c)
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c74952447.sumlimit)
	c:RegisterEffect(e1)
end
function c74952447.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsAttackAbove(1800)
end
