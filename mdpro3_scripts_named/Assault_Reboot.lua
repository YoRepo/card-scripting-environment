--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 爆裂再起  (ID: 74431740)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把自己场上1只「/爆裂体」怪兽解放才能发动。和那只怪兽卡名不同的1只「/爆裂体」怪兽无视召唤条件从卡组守备表示特殊召唤。
-- ②：把墓地的这张卡除外，以「爆裂再起」以外的自己墓地的有「爆裂模式」的卡名记述的卡以及「爆裂模式」任意数量为对象才能发动（同名卡最多1张）。那些卡回到卡组。
--[[ __CARD_HEADER_END__ ]]

--バスター・リブート
function c74431740.initial_effect(c)
	aux.AddCodeList(c,80280737)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetLabel(0)
	e1:SetCountLimit(1,74431740)
	e1:SetCost(c74431740.cost)
	e1:SetTarget(c74431740.target)
	e1:SetOperation(c74431740.activate)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,74431741)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c74431740.tdtg)
	e2:SetOperation(c74431740.tdop)
	c:RegisterEffect(e2)
end
function c74431740.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c74431740.cfilter(c,e,tp)
	return c:IsSetCard(0x104f) and Duel.IsExistingMatchingCard(c74431740.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,c:GetCode())
		and Duel.GetMZoneCount(tp,c)>0
end
function c74431740.spfilter(c,e,tp,code)
	return not c:IsCode(code) and c:IsSetCard(0x104f) and c:IsType(TYPE_MONSTER)
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false,POS_FACEUP_DEFENSE)
end
function c74431740.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c74431740.cfilter,1,nil,e,tp)
	end
	local rg=Duel.SelectReleaseGroup(tp,c74431740.cfilter,1,1,nil,e,tp)
	Duel.SetTargetParam(rg:GetFirst():GetCode())
	Duel.Release(rg,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c74431740.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local code=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c74431740.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,code)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
	end
end
function c74431740.tdfilter(c,e)
	return not c:IsCode(74431740) and aux.IsCodeOrListed(c,80280737) and c:IsAbleToDeck()
		and (not e or c:IsCanBeEffectTarget(e))
end
function c74431740.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c74431740.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c74431740.tdfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.GetMatchingGroup(c74431740.tdfilter,tp,LOCATION_GRAVE,0,e:GetHandler(),e)
	aux.GCheckAdditional=aux.dncheck
	local sg=g:SelectSubGroup(tp,aux.TRUE,false,1,#g)
	aux.GCheckAdditional=nil
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,#sg,0,0)
end
function c74431740.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
