--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Tyr of the Nordic Champions  (ID: 2333365)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 2000 | DEF 2000
-- Setcode: 0x42
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent's monsters cannot target "Nordic" monsters for attacks, except "Tyr of the Nordic
-- Champions".
-- If there is no other "Nordic" monster on the field, destroy this card.
--[[ __CARD_HEADER_END__ ]]

--極星將テュール
function c2333365.initial_effect(c)
	--self destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c2333365.descon)
	c:RegisterEffect(e1)
	--battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetValue(c2333365.atlimit)
	c:RegisterEffect(e2)
end
function c2333365.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x42)
end
function c2333365.descon(e)
	return not Duel.IsExistingMatchingCard(c2333365.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c2333365.atlimit(e,c)
	return c:IsFaceup() and not c:IsCode(2333365) and c:IsSetCard(0x42)
end
