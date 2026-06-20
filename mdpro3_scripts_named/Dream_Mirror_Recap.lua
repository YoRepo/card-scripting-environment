--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 梦魔镜的说梦  (ID: 81038234)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 305
--
-- Effect Text:
-- ①：只要这张卡在魔法与陷阱区域存在，自己场上的「梦魔镜」怪兽为让自身的效果发动而被解放的场合，不去墓地回到持有者卡组。
-- ②：自己·对方的主要阶段，把魔法与陷阱区域的表侧表示的这张卡送去墓地才能发动。从自己墓地的卡以及除外的自己的卡之中选1张「圣光之梦魔镜」或者「黯黑之梦魔镜」在自己的场地区域表侧表示放置。那之后，可以把
-- 有放置的卡的卡名记述的1只怪兽从手卡特殊召唤。
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
