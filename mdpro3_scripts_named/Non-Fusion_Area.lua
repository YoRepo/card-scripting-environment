--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Non-Fusion Area  (ID: 27581098)
-- Type: Trap / Continuous
-- Setcode: 0x46
-- Scope: OCG / TCG
--
-- Effect Text:
-- Neither player can Fusion Summon.
--[[ __CARD_HEADER_END__ ]]

--融合禁止エリア
function c27581098.initial_effect(c)
	--Activate
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
	e2:SetTarget(c27581098.splimit)
	c:RegisterEffect(e2)
end
function c27581098.splimit(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
