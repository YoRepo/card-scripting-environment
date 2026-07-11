--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Light and Darkness Ritual  (ID: 33599853)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon "Magician of Dark Chaos - Black Chaos" or "Black Luster
-- Soldier - Soldier of Light and Darkness".
-- You must also Tribute monsters from your hand or field, and/or banish monsters from your GY, whose
-- total Levels equal or exceed its Level.
-- If this card is in your GY: You can add this card and 1 card that mentions "Light and Darkness
-- Ritual" from your GY to your hand.
-- You can only use this effect of "Light and Darkness Ritual" once per turn.
--[[ __CARD_HEADER_END__ ]]

--光と闇の儀式
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,33599853,44001993,70405001)
	local e1=aux.AddRitualProcGreater2(c,s.rfilter,nil,s.grfilter)
	e1:SetDescription(aux.Stringid(id,0))
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
end
function s.rfilter(c)
	return c:IsCode(44001993,70405001)
end
function s.grfilter(c)
	return c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end
function s.thfilter(c)
	return aux.IsCodeListed(c,33599853) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToHand()
		and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_GRAVE,0,1,c) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_GRAVE)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and aux.NecroValleyFilter()(c) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_GRAVE,0,1,1,c)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			g:AddCard(c)
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
