--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: General Grunard of the Ice Barrier  (ID: 9056100)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level: 8
-- ATK 2800 | DEF 1000
-- Setcode: 0x2f
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Main Phase, you can Normal Summon 1 "Ice Barrier" monster in addition to your Normal
-- Summon/Set.
-- (You can only gain this effect once per turn.)
--[[ __CARD_HEADER_END__ ]]

--氷結界の虎将 グルナード
function c9056100.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9056100,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x2f))
	c:RegisterEffect(e1)
end
