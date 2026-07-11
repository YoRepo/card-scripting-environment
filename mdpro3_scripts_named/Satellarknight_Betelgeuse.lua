--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Satellarknight Betelgeuse  (ID: 26057276)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 700 | DEF 1900
-- Setcode: 0x9c
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Summoned: You can target 1 "tellarknight" card in your Graveyard, except
-- "Satellarknight Betelgeuse"; send this card to the Graveyard, and if you do, add that target to your
-- hand.
-- You can only use this effect of "Satellarknight Betelgeuse" once per turn.
--[[ __CARD_HEADER_END__ ]]

--星因士 ベテルギウス
function c26057276.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26057276,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,26057276)
	e1:SetTarget(c26057276.target)
	e1:SetOperation(c26057276.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	c26057276.star_knight_summon_effect=e1
end
function c26057276.filter(c)
	return c:IsSetCard(0x9c) and not c:IsCode(26057276) and c:IsAbleToHand()
end
function c26057276.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc,exc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c26057276.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c26057276.filter,tp,LOCATION_GRAVE,0,1,exc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c26057276.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c26057276.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SendtoGrave(c,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_GRAVE) then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
		end
	end
end
