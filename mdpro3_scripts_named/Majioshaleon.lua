--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Majioshaleon  (ID: 67211766)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level: 5
-- ATK 2000 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent cannot select this card as an attack target while they control any Spell/Trap Cards.
-- During battle between this attacking card and a Defense Position monster whose DEF is lower than the
-- ATK of this card, inflict the difference as Battle Damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--マジオシャレオン
function c67211766.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c67211766.ccon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c67211766.ccon(e)
	return Duel.IsExistingMatchingCard(Card.IsType,e:GetHandlerPlayer(),0,LOCATION_ONFIELD,1,nil,TYPE_SPELL+TYPE_TRAP)
end
