--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Super Vehicroid Jumbo Drill  (ID: 36256625)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Machine
-- Level: 8
-- ATK 3000 | DEF 2000
-- Setcode: 0x1016
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Steamroid" + "Drillroid" + "Submarineroid"
-- A Fusion Summon of this card can only be done with the above Fusion Materials.
-- If this card attacks a Defense Position monster, inflict piercing battle damage.
--[[ __CARD_HEADER_END__ ]]

--スーパービークロイド－ジャンボドリル
function c36256625.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,44729197,71218746,99861526,false,false)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
