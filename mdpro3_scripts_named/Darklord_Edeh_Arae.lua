--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Darklord Edeh Arae  (ID: 47664723)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level: 5
-- ATK 2300 | DEF 2000
-- Setcode: 0xef
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Special Summoned from the GY, it gains this effect.
-- ● If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--堕天使エデ・アーラエ
function c47664723.initial_effect(c)
	--spsum success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c47664723.gete)
	c:RegisterEffect(e1)
end
function c47664723.gete(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsPreviousLocation(LOCATION_GRAVE) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
end
