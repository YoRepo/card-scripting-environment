--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Honeybot  (ID: 34472920)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Cyberse
-- Link Rating: 2
-- Link Arrows: Left, Right
-- ATK 1900
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Cyberse monsters
-- Neither player can target monsters this card points to with card effects, and those monsters cannot
-- be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--ハニーボット
function c34472920.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2,2)
	c:EnableReviveLimit()
	--cannot be target/battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c34472920.tgtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	c:RegisterEffect(e2)
end
function c34472920.tgtg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end
