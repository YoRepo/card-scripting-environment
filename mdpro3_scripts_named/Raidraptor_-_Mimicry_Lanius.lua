--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Raidraptor - Mimicry Lanius  (ID: 96345188)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level: 4
-- ATK 1100 | DEF 1900
-- Setcode: 0xba
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during your Main Phase, if this card was Normal or Special Summoned this turn: You
-- can increase the Levels of all "Raidraptor" monsters you currently control by 1.
-- During your Main Phase, if this card is in the GY because it was sent there this turn: You can
-- banish this card; add 1 "Raidraptor" card from your Deck to your hand, except "Raidraptor - Mimicry
-- Lanius".
-- You can only use this effect of "Raidraptor - Mimicry Lanius" once per turn.
--[[ __CARD_HEADER_END__ ]]

--RR－ミミクリー・レイニアス
function c96345188.initial_effect(c)
	--level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c96345188.lvcon)
	e1:SetTarget(c96345188.lvtg)
	e1:SetOperation(c96345188.lvop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,96345188)
	e2:SetCondition(c96345188.thcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c96345188.thtg)
	e2:SetOperation(c96345188.thop)
	c:RegisterEffect(e2)
	if not c96345188.global_check then
		c96345188.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		ge1:SetLabel(96345188)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge2:SetLabel(96345188)
		Duel.RegisterEffect(ge2,0)
	end
end
function c96345188.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(96345188)>0
end
function c96345188.filter(c)
	return c:IsFaceup() and c:GetLevel()>0 and c:IsSetCard(0xba)
end
function c96345188.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c96345188.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c96345188.lvop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c96345188.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c96345188.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetTurnID()==Duel.GetTurnCount() and not e:GetHandler():IsReason(REASON_RETURN)
end
function c96345188.thfilter(c)
	return c:IsSetCard(0xba) and not c:IsCode(96345188) and c:IsAbleToHand()
end
function c96345188.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c96345188.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c96345188.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c96345188.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
