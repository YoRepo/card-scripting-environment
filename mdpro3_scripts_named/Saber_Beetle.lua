--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Saber Beetle  (ID: 49645921)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level: 6
-- ATK 2400 | DEF 600
-- Setcode: 0xd
-- Scope: OCG / TCG
--
-- Effect Text:
-- During battle between this attacking card and a Defense Position monster whose DEF is lower than the
-- ATK of this card, inflict the difference as Battle Damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--セイバー・ビートル
function c49645921.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
