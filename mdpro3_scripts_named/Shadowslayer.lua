--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Shadowslayer  (ID: 20939559)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 1400 | DEF 200
-- Scope: OCG / TCG
--
-- Effect Text:
-- If all monsters your opponent controls are in Defense Position, this card can attack your opponent
-- directly.
--[[ __CARD_HEADER_END__ ]]

--闇の住人 シャドウキラー
function c20939559.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c20939559.con)
	c:RegisterEffect(e1)
end
function c20939559.con(e)
	return not Duel.IsExistingMatchingCard(Card.IsAttackPos,e:GetHandler():GetControler(),0,LOCATION_MZONE,1,nil)
end
