--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Black Tyranno  (ID: 38670435)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level: 7
-- ATK 2600 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- If the only cards your opponent controls are Defense Position monsters, this card can attack
-- directly.
--[[ __CARD_HEADER_END__ ]]

--暗黒恐獣
function c38670435.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c38670435.dircon)
	c:RegisterEffect(e1)
end
function c38670435.dircon(e)
	local tp=e:GetHandler():GetControler()
	return not Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_MZONE,1,nil,TYPE_SPELL+TYPE_TRAP)
		and not Duel.IsExistingMatchingCard(Card.IsAttackPos,tp,0,LOCATION_MZONE,1,nil)
end
