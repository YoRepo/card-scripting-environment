--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Patrician of Darkness  (ID: 19153634)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level: 5
-- ATK 2000 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- You choose the attack targets for your opponent's attacks.
--[[ __CARD_HEADER_END__ ]]

--ノーブル・ド・ノワール
function c19153634.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_PATRICIAN_OF_DARKNESS)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	c:RegisterEffect(e1)
end
