--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 鱼群探知机  (ID: 22819092)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把7星以下的1只有「海」的卡名记述的怪兽或者水属性通常怪兽加入手卡。场上有「海」存在的场合，可以再从卡组把1只水属性通常怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魚群探知機
function c22819092.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,22819092+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c22819092.target)
	e1:SetOperation(c22819092.activate)
	c:RegisterEffect(e1)
end
function c22819092.filter(c)
	return c:IsAbleToHand() and c:IsLevelBelow(7)
		and (aux.IsCodeListed(c,22702055) or (c:IsType(TYPE_NORMAL) and c:IsAttribute(ATTRIBUTE_WATER)))
end
function c22819092.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22819092.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c22819092.spfilter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22819092.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c22819092.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleHand(tp)
		if Duel.IsEnvironment(22702055) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c22819092.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)
			and Duel.SelectYesNo(tp,aux.Stringid(22819092,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=Duel.SelectMatchingCard(tp,c22819092.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
