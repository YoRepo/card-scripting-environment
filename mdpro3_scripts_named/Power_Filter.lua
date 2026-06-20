--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 召唤限制-力量过滤器  (ID: 19844995)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 双方玩家不能把攻击力1000以下的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--召喚制限－パワーフィルター
function c19844995.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--disable spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(c19844995.sumlimit)
	c:RegisterEffect(e2)
end
function c19844995.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsAttackBelow(1000)
end
