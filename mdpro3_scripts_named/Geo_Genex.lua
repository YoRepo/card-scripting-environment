--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Geo Genex  (ID: 33972299)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Machine
-- Level: 6
-- ATK 1800 | DEF 2800
-- Setcode: 0x2
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Genex Controller" + 1 or more non-Tuner EARTH monsters
-- Once per turn, if you control a face-up Level 4 or lower "Genex" monster(s), you can switch the
-- original ATK and DEF of this card until the End Phase, for as long as you control a face-up Level 4
-- or lower "Genex" monster(s).
--[[ __CARD_HEADER_END__ ]]

--ジオ・ジェネクス
function c33972299.initial_effect(c)
	aux.AddMaterialCodeList(c,68505803)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsCode,68505803),aux.NonTuner(Card.IsAttribute,ATTRIBUTE_EARTH),1)
	c:EnableReviveLimit()
	--ad change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33972299,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c33972299.condition)
	e1:SetOperation(c33972299.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_SWAP_BASE_AD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c33972299.valcon)
	c:RegisterEffect(e2)
end
function c33972299.valcon(e)
	return e:GetHandler():GetFlagEffect(33972299)~=0
		and Duel.IsExistingMatchingCard(c33972299.cfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
function c33972299.cfilter(c)
	return c:IsLevelBelow(4) and c:IsFaceup() and c:IsSetCard(0x2)
end
function c33972299.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c33972299.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c33972299.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		c:RegisterFlagEffect(33972299,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end
