--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Numen erat Testudo  (ID: 83061014)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 5
-- ATK 1800 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- Neither player can Special Summon monsters with 1800 or less ATK.
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
