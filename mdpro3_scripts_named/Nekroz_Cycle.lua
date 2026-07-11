--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Nekroz Cycle  (ID: 97211663)
-- Type: Spell / Ritual
-- Setcode: 0xb4
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon any "Nekroz" Ritual Monster.
-- Tribute monsters from your hand or field, then Ritual Summon 1 "Nekroz" Ritual Monster from your
-- hand or GY whose Level equals the total Levels of those monsters.
-- You can only use this effect of "Nekroz Cycle" once per turn.
-- If you control no monsters: You can banish this card and 1 "Nekroz" monster from your GY; add 1
-- "Nekroz" Spell from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--影霊衣の反魂術
function c97211663.initial_effect(c)
	--Activate
	local e1=aux.AddRitualProcEqual2(c,c97211663.filter,LOCATION_HAND+LOCATION_GRAVE,nil,nil,true)
	e1:SetCountLimit(1,97211663)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c97211663.thcon)
	e2:SetCost(c97211663.thcost)
	e2:SetTarget(c97211663.thtg)
	e2:SetOperation(c97211663.thop)
	c:RegisterEffect(e2)
end
function c97211663.filter(c)
	return c:IsSetCard(0xb4)
end
function c97211663.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c97211663.cfilter(c)
	return c:IsSetCard(0xb4) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c97211663.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c97211663.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c97211663.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c97211663.thfilter(c)
	return c:IsSetCard(0xb4) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c97211663.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c97211663.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c97211663.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c97211663.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
