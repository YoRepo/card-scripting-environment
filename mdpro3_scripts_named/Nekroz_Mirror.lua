--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Nekroz Mirror  (ID: 14735698)
-- Type: Spell / Ritual
-- Setcode: 0xb4
-- Scope: OCG / TCG
--
-- Effect Text:
-- Can be used to Ritual Summon any "Nekroz" Ritual Monster.
-- Tribute monsters from your hand or field, and/or banish "Nekroz" monsters from your GY, then Ritual
-- Summon 1 "Nekroz" Ritual Monster from your hand whose Level equals the total Levels of those
-- monsters.
-- You can only use this effect of "Nekroz Mirror" once per turn.
-- If you control no monsters: You can banish this card and 1 "Nekroz" monster from your GY; add 1
-- "Nekroz" Spell from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--影霊衣の降魔鏡
function c14735698.initial_effect(c)
	--Activate
	local e1=aux.AddRitualProcEqual2(c,c14735698.filter,nil,c14735698.filter,nil,true)
	e1:SetCountLimit(1,14735698)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c14735698.thcon)
	e2:SetCost(c14735698.thcost)
	e2:SetTarget(c14735698.thtg)
	e2:SetOperation(c14735698.thop)
	c:RegisterEffect(e2)
end
function c14735698.filter(c)
	return c:IsSetCard(0xb4)
end
function c14735698.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c14735698.cfilter(c)
	return c:IsSetCard(0xb4) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c14735698.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c14735698.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c14735698.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c14735698.thfilter(c)
	return c:IsSetCard(0xb4) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c14735698.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c14735698.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c14735698.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c14735698.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
