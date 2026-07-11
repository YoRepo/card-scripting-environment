--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Constellar Leonis  (ID: 17129783)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 3
-- ATK 1000 | DEF 1800
-- Setcode: 0x53
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Main Phase, you can Normal Summon 1 "Constellar" monster in addition to your Normal
-- Summon/Set.
-- (You can only gain this effect once per turn.)
--[[ __CARD_HEADER_END__ ]]

--セイクリッド・レオニス
function c17129783.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17129783,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x53))
	c:RegisterEffect(e1)
end
