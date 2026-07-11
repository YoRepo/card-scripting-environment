--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Chaos Form  (ID: 21082832)
-- Type: Spell / Ritual
-- Setcode: 0xcf
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon any "Chaos" or "Black Luster Soldier" Ritual Monster.
-- You must also Tribute monsters from your hand or field and/or banish "Blue-Eyes White Dragon" or
-- "Dark Magician" from your GY, whose total Levels exactly equal the Level of the "Chaos" or "Black
-- Luster Soldier" Ritual Monster you Ritual Summon.
--[[ __CARD_HEADER_END__ ]]

--カオス・フォーム
function c21082832.initial_effect(c)
	aux.AddCodeList(c,46986414,89631139)
	aux.AddRitualProcEqual2(c,c21082832.filter,nil,c21082832.mfilter)
end
function c21082832.filter(c,e,tp,m1,m2,ft)
	return c:IsSetCard(0xcf)
end
function c21082832.mfilter(c)
	return c:IsCode(46986414,89631139)
end
