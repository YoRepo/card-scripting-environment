--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Leng Ling  (ID: 70298454)
-- Type: Monster / Effect / Union
-- Attribute: DARK
-- Race: Dragon
-- Level: 3
-- ATK 1500 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can either: Target 1 face-up monster you control; equip this card to that target,
-- OR: Unequip this card and Special Summon it.
-- The original ATK of a monster equipped with this card becomes 1000, it can make a second attack
-- during each Battle Phase, also if the equipped monster would be destroyed by battle or card effect,
-- destroy this card instead.
--[[ __CARD_HEADER_END__ ]]

--比翼レンリン
function c70298454.initial_effect(c)
	aux.EnableUnionAttribute(c,aux.TRUE)
	--change atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_SET_BASE_ATTACK)
	e4:SetValue(1000)
	c:RegisterEffect(e4)
	--double attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_EXTRA_ATTACK)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
