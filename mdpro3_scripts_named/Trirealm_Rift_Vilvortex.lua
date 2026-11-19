--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-19T23:32:31
-- Source DB: cards.cdb
-- Card: Trirealm Rift Vilvortex  (ID: 33700664)
-- Type: Spell / Field
-- Setcode: 0x1ed
-- Scope: OCG
--
-- Effect Text:
-- Activate this card by banishing (face-down) 5 cards from your GY and/or the top of your Deck.
-- During your Main Phase: You can add 1 of your face-down banished "Trirealm Rift" cards to your hand,
-- except "Trirealm Rift Vilvortex".
-- You can only use this effect of "Trirealm Rift Vilvortex" once per turn.
-- During your turn, while you control a Level 5 or higher "Trirealm Rift" monster and have no cards in
-- your Deck, your opponent cannot activate cards or effects.
--[[ __CARD_HEADER_END__ ]]

--異解△領域－ヴァルヴォルス
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(s.cost)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
	--act limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(0,1)
	e3:SetCondition(s.limcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local dct=Duel.GetMatchingGroupCount(Card.IsAbleToRemoveAsCost,tp,LOCATION_DECK,0,nil,POS_FACEDOWN)
	if chk==0 then return dct>=5 or dct<5 and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,5-dct,nil,POS_FACEDOWN) end
	if dct>5 then dct=5 end
	local gg=Group.CreateGroup()
	if dct>=5 and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,1,nil,POS_FACEDOWN)
		and Duel.SelectYesNo(tp,aux.Stringid(id,0))
		or dct<5 then
		local st=dct
		if st==5 then st=4 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		gg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,5-st,5,nil,POS_FACEDOWN)
		Duel.HintSelection(gg)
	end
	if gg:GetCount()>0 then
		dct=5-gg:GetCount()
	end
	local dg=Duel.GetDecktopGroup(tp,dct)
	if dct<5 then
		dg:Merge(gg)
	end
	Duel.DisableShuffleCheck()
	if Duel.Remove(dg,POS_FACEDOWN,REASON_COST)~=0 then
		for tc in aux.Next(dg) do
			if tc:IsFacedown() and tc:IsLocation(LOCATION_REMOVED) then
				tc:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(id,2))
			end
		end
	end
end
function s.thfilter(c)
	return c:IsFacedown() and not c:IsCode(id) and c:IsSetCard(0x1ed) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_REMOVED)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1ed) and c:IsLevelAbove(5)
end
function s.limcon(e)
	return Duel.IsExistingMatchingCard(s.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
		and Duel.GetMatchingGroupCount(aux.TRUE,e:GetHandlerPlayer(),LOCATION_DECK,0,nil)==0
		and Duel.IsTurnPlayer(e:GetHandlerPlayer())
end
