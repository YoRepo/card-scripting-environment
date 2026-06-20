--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 卫星闪灵·淘气精灵  (ID: 27381364)
-- Type: Monster / Effect / Link
-- Attribute: FIRE
-- Race: Thunder
-- ATK 1400 | LINK
-- Setcode: 384
--
-- Effect Text:
-- 包含2星·2阶·连接2的怪兽在内的怪兽2只
-- 这张卡在连接召唤的回合不能作为连接素材。这个卡名的②的效果1回合只能使用1次。
-- ①：对方不能把这张卡所连接区的怪兽作为效果的对象。
-- ②：自己·对方的主要阶段，以自己墓地1只2星怪兽为对象才能发动（对方场上有怪兽存在的场合，也能作为代替以1只2阶或者连接2的怪兽为对象）。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スプライト・エルフ
function c27381364.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,2,c27381364.lcheck)
	--cannot link material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetValue(c27381364.lmlimit)
	c:RegisterEffect(e1)
	--cannot be effect target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c27381364.etlimit)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,27381364)
	e3:SetCondition(c27381364.spcon)
	e3:SetTarget(c27381364.sptg)
	e3:SetOperation(c27381364.spop)
	c:RegisterEffect(e3)
end
function c27381364.lcheck(g,lc)
	return g:IsExists(Card.IsLevel,1,nil,2) or g:IsExists(Card.IsRank,1,nil,2) or g:IsExists(Card.IsLink,1,nil,2)
end
function c27381364.lmlimit(e)
	local c=e:GetHandler()
	return c:IsStatus(STATUS_SPSUMMON_TURN) and c:IsSummonType(SUMMON_TYPE_LINK)
end
function c27381364.etlimit(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end
function c27381364.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c27381364.spfilter(c,e,tp,check)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and (c:IsLevel(2) or (check and (c:IsRank(2) or c:IsLink(2))))
end
function c27381364.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local check=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c27381364.spfilter(chkc,e,tp,check) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c27381364.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,check) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c27381364.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,check)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c27381364.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
