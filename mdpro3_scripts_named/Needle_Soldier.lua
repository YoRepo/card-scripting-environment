--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Needle Soldier  (ID: 17841097)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 1
-- ATK 100 | DEF 100
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is used as a Synchro Material Monster for a Synchro Monster, during battle between that
-- Synchro Monster and a Defense Position monster whose DEF is lower than the ATK of that Synchro
-- Monster, inflict the difference as Battle Damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--ニードル・ガンナー
function c17841097.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_EVENT_PLAYER)
	e1:SetCondition(c17841097.pscon)
	e1:SetOperation(c17841097.psop)
	c:RegisterEffect(e1)
end
function c17841097.pscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c17841097.psop(e,tp,eg,ep,ev,re,r,rp)
	local rc=e:GetHandler():GetReasonCard()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	rc:RegisterEffect(e1,true)
end
