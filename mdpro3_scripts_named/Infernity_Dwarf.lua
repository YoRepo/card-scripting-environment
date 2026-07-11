--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Infernity Dwarf  (ID: 25171661)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 2
-- ATK 800 | DEF 500
-- Setcode: 0xb
-- Scope: OCG / TCG
--
-- Effect Text:
-- While you have no cards in your hand, if a monster you control attacks a Defense Position monster,
-- inflict piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・ドワーフ
function c25171661.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c25171661.condition)
	c:RegisterEffect(e1)
end
function c25171661.condition(e)
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)==0
end
