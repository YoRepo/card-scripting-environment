--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Condemned Maiden  (ID: 68018709)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 4
-- ATK 100 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your opponent's turn, you can activate 1 Quick-Play Spell Card from your hand.
-- You can only use this effect of "Condemned Maiden" once per Duel.
--[[ __CARD_HEADER_END__ ]]

--失楽の聖女
function c68018709.initial_effect(c)
	--act qp in hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68018709,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCountLimit(1,68018709+EFFECT_COUNT_CODE_DUEL)
	c:RegisterEffect(e1)
end
