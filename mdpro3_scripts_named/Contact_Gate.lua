--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 接触之门  (ID: 41933425)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己墓地把「新空间侠」怪兽2种类各1只除外才能发动。从自己的手卡·卡组·墓地选2只「新空间侠」怪兽特殊召唤（同名卡最多1张）。这个效果发动过的回合，自己不是融合怪兽不能从额外卡组特殊召唤。
-- ②：自己场上的表侧表示的需以「元素英雄 新宇侠」为融合素材的融合怪兽回到额外卡组的场合，把墓地的这张卡除外才能发动。选除外的1只自己的「新空间侠」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--コンタクト・ゲート
function c41933425.initial_effect(c)
	aux.AddCodeList(c,89943723)
	aux.AddSetNameMonsterList(c,0x3008)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,41933425+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c41933425.cost)
	e1:SetTarget(c41933425.target)
	e1:SetOperation(c41933425.activate)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41933425,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c41933425.spcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c41933425.sptg)
	e2:SetOperation(c41933425.spop)
	c:RegisterEffect(e2)
end
function c41933425.cfilter1(c,e,tp)
	return c:IsSetCard(0x1f) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c41933425.cfilter2,tp,LOCATION_GRAVE,0,1,c,e,tp,c)
end
function c41933425.cfilter2(c,e,tp,tc)
	if c:IsCode(tc:GetCode()) then return false end
	local sg=Group.FromCards(tc,c)
	local g=Duel.GetMatchingGroup(c41933425.spfilter1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,sg,e,tp)
	return c:IsSetCard(0x1f) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost() and g:GetClassCount(Card.GetCode)>1
end
function c41933425.spfilter1(c,e,tp)
	return c:IsSetCard(0x1f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c41933425.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41933425.cfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c41933425.cfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c41933425.cfilter2,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp,g1:GetFirst())
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c41933425.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c41933425.spfilter1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,nil,e,tp)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and g:GetClassCount(Card.GetCode)>1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c41933425.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c41933425.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c41933425.spfilter1),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,nil,e,tp)
	if g:GetClassCount(Card.GetCode)>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg1=g:SelectSubGroup(tp,aux.dncheck,false,2,2)
		Duel.SpecialSummon(sg1,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c41933425.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsType(TYPE_FUSION) and c:IsLocation(LOCATION_EXTRA)
end
function c41933425.confilter(c,tp)
	return c:IsType(TYPE_FUSION) and aux.IsMaterialListCode(c,89943723) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp) and c:IsLocation(LOCATION_EXTRA)
end
function c41933425.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c41933425.confilter,1,nil,tp)
end
function c41933425.spfilter2(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x1f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c41933425.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c41933425.spfilter2,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function c41933425.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c41933425.spfilter2,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
