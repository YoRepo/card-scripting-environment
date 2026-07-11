--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Dogmatikaturgy  (ID: 42158279)
-- Type: Trap
-- Setcode: 0x145
-- Scope: OCG / TCG
--
-- Effect Text:
-- Ritual Summon 1 "Dogmatika" Ritual Monster from your hand or Deck by Tributing "Dogmatika" monsters
-- and/or Ritual, Fusion, or Synchro Monsters from your field whose total Levels equal the Level of the
-- Ritual Monster you Ritual Summon.
-- If this card is in your GY: You can banish this card, then target 2 "Dogmatika" monsters with
-- different Levels in your GY; add 1 of them to your hand, and place the other on the bottom of your
-- Deck.
-- You can only use 1 "Dogmatikaturgy" effect per turn, and only once that turn.
--[[ __CARD_HEADER_END__ ]]

--ドラグマトゥルギー
function c42158279.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,42158279)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c42158279.target)
	e1:SetOperation(c42158279.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,42158279)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c42158279.thtg)
	e2:SetOperation(c42158279.thop)
	c:RegisterEffect(e2)
end
function c42158279.filter(c,e,tp)
	return c:IsSetCard(0x145)
end
function c42158279.matfilter(c)
	return c:IsLocation(LOCATION_MZONE) and (c:IsSetCard(0x145) or c:IsType(TYPE_RITUAL+TYPE_FUSION+TYPE_SYNCHRO))
end
function c42158279.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetRitualMaterial(tp):Filter(c42158279.matfilter,nil)
		return Duel.IsExistingMatchingCard(aux.RitualUltimateFilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,c42158279.filter,e,tp,mg,nil,Card.GetLevel,"Equal")
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c42158279.activate(e,tp,eg,ep,ev,re,r,rp)
	::cancel::
	local mg=Duel.GetRitualMaterial(tp):Filter(c42158279.matfilter,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.RitualUltimateFilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,c42158279.filter,e,tp,mg,nil,Card.GetLevel,"Equal")
	local tc=g:GetFirst()
	if tc then
		mg=mg:Filter(Card.IsCanBeRitualMaterial,tc,tc)
		if tc.mat_filter then
			mg=mg:Filter(tc.mat_filter,tc,tp)
		else
			mg:RemoveCard(tc)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		aux.GCheckAdditional=aux.RitualCheckAdditional(tc,tc:GetLevel(),"Equal")
		local mat=mg:SelectSubGroup(tp,aux.RitualCheck,true,1,tc:GetLevel(),tp,tc,tc:GetLevel(),"Equal")
		aux.GCheckAdditional=nil
		if not mat then goto cancel end
		tc:SetMaterial(mat)
		Duel.ReleaseRitualMaterial(mat)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
function c42158279.thfilter(c,e)
	return c:IsSetCard(0x145) and c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e)
end
function c42158279.fselect(g)
	return aux.dlvcheck(g) and g:IsExists(c42158279.fcheck,1,nil,g)
end
function c42158279.fcheck(c,g)
	return c:IsAbleToHand() and g:IsExists(c42158279.fcheck2,1,c)
end
function c42158279.fcheck2(c)
	return c:IsAbleToDeck()
end
function c42158279.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetMatchingGroup(c42158279.thfilter,tp,LOCATION_GRAVE,0,nil,e)
	if chk==0 then return g:CheckSubGroup(c42158279.fselect,2,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local sg=g:SelectSubGroup(tp,c42158279.fselect,false,2,2)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,1,tp,LOCATION_GRAVE)
end
function c42158279.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:FilterCount(Card.IsRelateToEffect,nil,e)<2 or not g:IsExists(c42158279.fcheck,1,nil,g) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,c42158279.fcheck,1,1,nil,g)
	if Duel.SendtoHand(sg,nil,REASON_EFFECT)>0 and sg:GetFirst():IsLocation(LOCATION_HAND) then
		Duel.SendtoDeck(g-sg,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
	end
end
