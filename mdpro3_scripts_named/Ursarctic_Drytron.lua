--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 天斗辉巧极  (ID: 89771220)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 22282595
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：从自己的手卡·场上把「北极天熊北斗星」和「龙辉巧-扶筐增二」各1张除外，把1只「天极辉舰-熊斗龙巧」从额外卡组特殊召唤。场上有「北极天熊-勾陈一」或者「龙辉巧-右枢α」存在的场合，也能把要除外的卡
-- 之内1张从卡组除外。
-- ②：自己为让「北极天熊」、「龙辉巧」怪兽的效果发动而把怪兽解放的场合，可以作为代替把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--天斗輝巧極
function c89771220.initial_effect(c)
	aux.AddCodeList(c,89264428,58793369,97148796,27693363)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c89771220.target)
	e1:SetOperation(c89771220.activate)
	c:RegisterEffect(e1)
	--replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(89771220)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,89771220)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(16471775)
	c:RegisterEffect(e3)
end
function c89771220.deckconfilter(c)
	return c:IsCode(97148796,27693363) and c:IsFaceup()
end
function c89771220.deckcon(tp)
	return Duel.IsExistingMatchingCard(c89771220.deckconfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c89771220.cfilter(c)
	return c:IsCode(89264428,58793369) and c:IsAbleToRemove()
end
function c89771220.fselect(g,e,tp)
	return g:GetClassCount(Card.GetCode)==2 and g:FilterCount(Card.IsLocation,nil,LOCATION_DECK)<=1
		and Duel.IsExistingMatchingCard(c89771220.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,g)
end
function c89771220.spfilter(c,e,tp,g)
	return c:IsCode(33250142) and c:IsCanBeSpecialSummoned(e,0,tp,false,true)
		and Duel.GetLocationCountFromEx(tp,tp,g,c)>0
end
function c89771220.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local loc=LOCATION_HAND+LOCATION_ONFIELD
	if c89771220.deckcon(tp) then loc=loc|LOCATION_DECK end
	local g=Duel.GetMatchingGroup(c89771220.cfilter,tp,loc,0,nil)
	if chk==0 then return g:CheckSubGroup(c89771220.fselect,2,2,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,2,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c89771220.activate(e,tp,eg,ep,ev,re,r,rp)
	local loc=LOCATION_HAND+LOCATION_ONFIELD
	if c89771220.deckcon(tp) then loc=loc|LOCATION_DECK end
	local g=Duel.GetMatchingGroup(c89771220.cfilter,tp,loc,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=g:SelectSubGroup(tp,c89771220.fselect,false,2,2,e,tp)
	if rg and Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c89771220.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,nil)
		if #sg>0 then
			Duel.SpecialSummon(sg,0,tp,tp,false,true,POS_FACEUP)
			sg:GetFirst():CompleteProcedure()
		end
	end
end
