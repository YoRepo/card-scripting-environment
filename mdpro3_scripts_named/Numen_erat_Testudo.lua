--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 后被称为龟的神  (ID: 83061014)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 5
-- ATK 1800 | DEF 0
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，双方不能把攻击力1800以下的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--後に亀と呼ばれる神
function c83061014.initial_effect(c)
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c83061014.sumlimit)
	c:RegisterEffect(e1)
end
function c83061014.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsAttackBelow(1800)
end
