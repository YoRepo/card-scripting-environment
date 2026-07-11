--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Chaos Necromancer  (ID: 1434352)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 1
-- ATK 0 | DEF 0
-- Setcode: 0xcf
-- Scope: OCG / TCG
--
-- Effect Text:
-- The ATK of this card is the number of Monster Cards in your Graveyard x 300.
--[[ __CARD_HEADER_END__ ]]

--カオス・ネクロマンサー
function c1434352.initial_effect(c)
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c1434352.atkval)
	c:RegisterEffect(e1)
end
function c1434352.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,c:GetControler(),LOCATION_GRAVE,0,nil,TYPE_MONSTER)*300
end
