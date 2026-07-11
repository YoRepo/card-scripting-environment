--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Royal Swamp Eel  (ID: 37953640)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Fish
-- Level: 4
-- ATK 1700 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is used as a Synchro Material Monster, all the other Synchro Material Monsters must be
-- Fish-Type.
--[[ __CARD_HEADER_END__ ]]

--竜宮の白タウナギ
function c37953640.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TUNER_MATERIAL_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTarget(c37953640.synlimit)
	c:RegisterEffect(e1)
end
function c37953640.synlimit(e,c)
	return c:IsRace(RACE_FISH)
end
