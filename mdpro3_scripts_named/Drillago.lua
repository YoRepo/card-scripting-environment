--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Drillago  (ID: 99050989)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 4
-- ATK 1600 | DEF 1100
-- Scope: OCG / TCG
--
-- Effect Text:
-- If the only cards your opponent controls are face-up monsters with 1600 or more ATK, this card can
-- attack your opponent directly.
--[[ __CARD_HEADER_END__ ]]

--ドリラゴ
function c99050989.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c99050989.dircon)
	c:RegisterEffect(e1)
end
function c99050989.filter(c)
	return c:GetAttack()<1600 or c:IsFacedown()
end
function c99050989.dircon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetFieldGroupCount(tp,0,LOCATION_SZONE)==0
		and not Duel.IsExistingMatchingCard(c99050989.filter,tp,0,LOCATION_MZONE,1,nil)
end
