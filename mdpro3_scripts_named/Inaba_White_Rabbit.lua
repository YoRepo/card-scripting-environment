--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Inaba White Rabbit  (ID: 77084837)
-- Type: Monster / Effect / Spirit
-- Attribute: EARTH
-- Race: Beast
-- Level: 3
-- ATK 700 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card cannot be Special Summoned.
-- This card returns to the owner's hand during the End Phase of the turn that this card is Normal
-- Summoned or flipped face-up.
-- This monster attacks your opponent's Life Points directly.
--[[ __CARD_HEADER_END__ ]]

--因幡之白兎
function c77084837.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--attack limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
