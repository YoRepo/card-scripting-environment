--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Noble Knight's Shield-Bearer  (ID: 34242278)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 800 | DEF 1300
-- Setcode: 0x107a
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Normal or Special Summoned: You can banish 1 LIGHT monster from your GY; draw 1
-- card.
-- You can banish this card from your hand or field; add 1 Level 6 or lower WIND Beast monster from
-- your Deck to your hand.
-- You can only use 1 "Noble Knight's Shield-Bearer" effect per turn, and only once that turn.
--[[ __CARD_HEADER_END__ ]]

--聖騎士の盾持ち
function c34242278.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34242278,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,34242278)
	e1:SetCost(c34242278.drcost)
	e1:SetTarget(c34242278.drtg)
	e1:SetOperation(c34242278.drop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34242278,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e3:SetCountLimit(1,34242278)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c34242278.thtg)
	e3:SetOperation(c34242278.thop)
	c:RegisterEffect(e3)
end
function c34242278.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToRemoveAsCost()
end
function c34242278.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34242278.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c34242278.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c34242278.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c34242278.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c34242278.thfilter(c)
	return c:IsLevelBelow(6) and c:IsAttribute(ATTRIBUTE_WIND) and c:IsRace(RACE_BEAST) and c:IsAbleToHand()
end
function c34242278.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34242278.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c34242278.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c34242278.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
