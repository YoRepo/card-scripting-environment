--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Piercing Moray  (ID: 69846323)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 4
-- ATK 1500 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can Tribute 1 other Fish, Sea Serpent, or Aqua monster; this card gains 600 ATK.
-- If this card attacks a Defense Position monster, inflict piercing battle damage.
--[[ __CARD_HEADER_END__ ]]

--カンツウツボ
function c69846323.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69846323,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c69846323.cost)
	e1:SetOperation(c69846323.operation)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c69846323.cfilter(c)
	return c:IsRace(RACE_FISH+RACE_AQUA+RACE_SEASERPENT)
end
function c69846323.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c69846323.cfilter,1,e:GetHandler()) end
	local sg=Duel.SelectReleaseGroup(tp,c69846323.cfilter,1,1,e:GetHandler())
	Duel.Release(sg,REASON_COST)
end
function c69846323.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(600)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
