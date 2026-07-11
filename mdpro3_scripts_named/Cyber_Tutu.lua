--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Cyber Tutu  (ID: 49375719)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 3
-- ATK 1000 | DEF 800
-- Setcode: 0x93
-- Scope: OCG / TCG
--
-- Effect Text:
-- If the ATK of each monster your opponent controls is higher than this card's, this card can attack
-- directly.
--[[ __CARD_HEADER_END__ ]]

--サイバー・チュチュ
function c49375719.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c49375719.dacon)
	c:RegisterEffect(e1)
end
function c49375719.filter(c,atk)
	return c:IsFacedown() or c:GetAttack()<=atk
end
function c49375719.dacon(e)
	return not Duel.IsExistingMatchingCard(c49375719.filter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil,e:GetHandler():GetAttack())
end
