--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Flame Administrator  (ID: 49847524)
-- Type: Monster / Effect / Link
-- Attribute: FIRE
-- Race: Cyberse
-- Link Rating: 2
-- Link Arrows: Left, Bottom-Right
-- ATK 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Cyberse monsters
-- All Link Monsters you control gain 800 ATK.
-- You can only control 1 "Flame Administrator".
--[[ __CARD_HEADER_END__ ]]

--フレイム・アドミニスター
function c49847524.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,49847524)
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2,2)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_LINK))
	e1:SetValue(800)
	c:RegisterEffect(e1)
end
