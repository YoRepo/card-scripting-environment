--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Testudo erat Numen  (ID: 74952447)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 1
-- ATK 0 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- Neither player can Special Summon monsters with 1800 or more ATK.
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
