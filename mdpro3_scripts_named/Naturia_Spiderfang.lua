--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Naturia Spiderfang  (ID: 25654671)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level: 4
-- ATK 2100 | DEF 400
-- Setcode: 0x2a
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot declare an attack unless your opponent activated a card or effect this turn.
--[[ __CARD_HEADER_END__ ]]

--ナチュル・スパイダーファング
function c25654671.initial_effect(c)
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetCondition(c25654671.atkcon)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(25654671,ACTIVITY_CHAIN,aux.FALSE)
end
function c25654671.atkcon(e)
	return Duel.GetCustomActivityCount(25654671,1-e:GetHandlerPlayer(),ACTIVITY_CHAIN)==0
end
