--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Dream Mirror Recap  (ID: 81038234)
-- Type: Trap / Continuous
-- Setcode: 0x131
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a "Dream Mirror" monster you control would be Tributed to activate its own effect, shuffle it
-- into the Deck instead of sending it to the GY.
-- During the Main Phase: You can send this face-up card to the GY; place 1 of your "Dream Mirror of
-- Joy" or "Dream Mirror of Terror" that is banished or in your GY, face-up in your Field Zone, then
-- you can Special Summon 1 monster from your hand that specifically lists that card you placed in its
-- text.
--[[ __CARD_HEADER_END__ ]]

--夢魔鏡の夢語らい
function c81038234.initial_effect(c)
	aux.AddCodeList(c,74665651,1050355)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetTarget(c81038234.rmtg)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(LOCATION_DECKSHF)
	c:RegisterEffect(e2)
	--place
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(81038234,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c81038234.tfcon)
	e3:SetCost(c81038234.tfcost)
	e3:SetTarget(c81038234.tftg)
	e3:SetOperation(c81038234.tfop)
	c:RegisterEffect(e3)
end
function c81038234.rmtg(e,c)
	local re=c:GetReasonEffect()
	return c:IsSetCard(0x131) and c:IsReason(REASON_COST) and c:IsReason(REASON_RELEASE) and re and re:IsActivated() and re:GetHandler()==c
end
function c81038234.tfcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c81038234.tfcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsStatus(STATUS_EFFECT_ENABLED) end
	Duel.SendtoGrave(c,REASON_COST)
end
function c81038234.tffilter(c)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsCode(74665651,1050355)
end
function c81038234.tftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81038234.tffilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
end
function c81038234.spfilter(c,e,tp,code)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and aux.IsCodeListed(c,code)
end
function c81038234.tfop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c81038234.tffilter),tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,tp)
	if #tg==0 then return end
	Duel.HintSelection(tg)
	local tc=tg:GetFirst()
	local fc=Duel.GetFieldCard(tp,LOCATION_FZONE,0)
	if fc then
		Duel.SendtoGrave(fc,REASON_RULE)
		Duel.BreakEffect()
	end
	if Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,POS_FACEUP,true) then
		local g=Duel.GetMatchingGroup(c81038234.spfilter,tp,LOCATION_HAND,0,nil,e,tp,tc:GetCode())
		if #g>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(81038234,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:Select(tp,1,1,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
