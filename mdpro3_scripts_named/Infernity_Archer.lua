--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Infernity Archer  (ID: 18724123)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 6
-- ATK 2000 | DEF 1000
-- Setcode: 0xb
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you have no cards in your hand, this card can attack your opponent directly.
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・アーチャー
function c18724123.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c18724123.con)
	c:RegisterEffect(e1)
end
function c18724123.con(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)==0
end
