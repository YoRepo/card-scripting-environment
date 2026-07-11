--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Clara & Rushka, the Ventriloduo  (ID: 1482001)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Spellcaster
-- Link Rating: 1
-- Link Arrows: Top
-- ATK 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Normal Summoned/Set monster
-- Cannot be Link Summoned except during Main Phase 2.
--[[ __CARD_HEADER_END__ ]]

--副話術士クララ＆ルーシカ
function c1482001.initial_effect(c)
	c:EnableReviveLimit()
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsSummonType,SUMMON_TYPE_NORMAL),1,1)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_COST)
	e1:SetCost(c1482001.spcost)
	c:RegisterEffect(e1)
end
function c1482001.spcost(e,c,tp,st)
	if bit.band(st,SUMMON_TYPE_LINK)~=SUMMON_TYPE_LINK then return true end
	return Duel.GetCurrentPhase()==PHASE_MAIN2
end
