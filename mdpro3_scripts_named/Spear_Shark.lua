--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Spear Shark  (ID: 70655556)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 4
-- ATK 1600 | DEF 1400
-- Setcode: 0x1b8
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can increase the Levels of all Level 3 Fish-Type monsters you
-- currently control by 1.
-- If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--スピア・シャーク
function c70655556.initial_effect(c)
	--lvup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70655556,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c70655556.lvtg)
	e1:SetOperation(c70655556.lvop)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c70655556.filter(c)
	return c:IsFaceup() and c:IsLevel(3) and c:IsRace(RACE_FISH)
end
function c70655556.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c70655556.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c70655556.lvop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c70655556.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
