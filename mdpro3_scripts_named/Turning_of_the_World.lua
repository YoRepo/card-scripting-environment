--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Turning of the World  (ID: 95612049)
-- Type: Spell / Quick-Play
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Ruin, Queen of Oblivion" or "Demise, King of Armageddon" from
-- your hand or Deck.
-- You must also Tribute Ritual Monsters from your hand whose total Levels equal or exceed the Level of
-- the Ritual Monster you Ritual Summon.
-- You can only activate 1 "Turning of the World" per turn.
--[[ __CARD_HEADER_END__ ]]

--リバース・オブ・ザ・ワールド
function c95612049.initial_effect(c)
	--Activate
	local e1=aux.AddRitualProcGreater2Code2(c,46427957,72426662,LOCATION_HAND+LOCATION_DECK,nil,c95612049.mfilter,true)
	e1:SetCountLimit(1,95612049+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
end
function c95612049.mfilter(c)
	return not c:IsOnField() and c:IsType(TYPE_RITUAL)
end
