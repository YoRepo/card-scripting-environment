--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Emissary of the Oasis  (ID: 6103294)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 3
-- ATK 600 | DEF 400
-- Scope: OCG / TCG
--
-- Effect Text:
-- While a face-up Level 3 or lower Normal Monster is on your side of the field, your opponent cannot
-- select this card as an attack target.
-- While this card is face-up on your side of the field, any Battle Damage to the controller of this
-- card from battle involving a Level 3 or lower Normal Monster becomes 0.
--[[ __CARD_HEADER_END__ ]]

--オアシスの使者
function c6103294.initial_effect(c)
	--atk target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c6103294.atkcon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetTarget(c6103294.cfilter2)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	e3:SetTarget(c6103294.cfilter2)
	c:RegisterEffect(e3)
end
function c6103294.cfilter1(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsLevelBelow(3)
end
function c6103294.cfilter2(e,c)
	return c:IsType(TYPE_NORMAL) and c:IsLevelBelow(3)
end
function c6103294.atkcon(e)
	return Duel.IsExistingMatchingCard(c6103294.cfilter1,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
