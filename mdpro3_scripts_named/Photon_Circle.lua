--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Photon Circle  (ID: 64145892)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 4
-- ATK 1000 | DEF 1000
-- Setcode: 0x55
-- Scope: OCG / TCG
--
-- Effect Text:
-- Any Battle Damage you take from battles involving this card is halved.
--[[ __CARD_HEADER_END__ ]]

--フォトン・サークラー
function c64145892.initial_effect(c)
	--damage reduce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_INVOLVING_BATTLE_DAMAGE)
	e1:SetValue(aux.ChangeBattleDamage(0,HALF_DAMAGE))
	c:RegisterEffect(e1)
end
