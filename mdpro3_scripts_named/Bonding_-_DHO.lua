--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 结合术-DHO  (ID: 6890729)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 256
--
-- Effect Text:
-- ①：从自己的手卡·墓地让「氘素龙」「氢素龙」「氧素龙」各1只回到卡组才能发动。从自己的手卡·墓地选1只「水龙-团簇」特殊召唤。
-- ②：把墓地的这张卡除外才能发动。从自己的卡组·墓地选1只「水龙」或者「水龙-团簇」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ボンディング－DHO
function c6890729.initial_effect(c)
	aux.AddCodeList(c,43017476,22587018,58071123,6022371,85066822)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c6890729.cost)
	e1:SetTarget(c6890729.target)
	e1:SetOperation(c6890729.activate)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c6890729.thtg)
	e2:SetOperation(c6890729.thop)
	c:RegisterEffect(e2)
end
c6890729.spchecks=aux.CreateChecks(Card.IsCode,{43017476,22587018,58071123})
function c6890729.spcostfilter(c)
	return c:IsAbleToDeckAsCost() and c:IsCode(43017476,22587018,58071123)
end
function c6890729.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c6890729.spcostfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and g:CheckSubGroupEach(c6890729.spchecks) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:SelectSubGroupEach(tp,c6890729.spchecks)
	Duel.ConfirmCards(1-tp,sg)
	Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function c6890729.filter(c,e,tp)
	return c:IsCode(6022371) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c6890729.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c6890729.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c6890729.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c6890729.filter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end
function c6890729.thfilter(c)
	return c:IsCode(6022371,85066822) and c:IsAbleToHand()
end
function c6890729.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6890729.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c6890729.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c6890729.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
