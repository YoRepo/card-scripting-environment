--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Monk Fighter  (ID: 3810071)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 3
-- ATK 1300 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Battle Damage to this card's controller from a battle involving this card becomes 0.
--[[ __CARD_HEADER_END__ ]]

--モンク・ファイター
function c3810071.initial_effect(c)
	--dam
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
