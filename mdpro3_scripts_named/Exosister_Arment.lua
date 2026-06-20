--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 救祓少女阿门武装  (ID: 4408198)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 370
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张，从墓地特殊召唤的怪兽不在对方场上存在的场合，不在对方回合不能发动。
-- ①：支付800基本分，以自己场上1只「救祓少女」怪兽为对象才能发动。同名卡不在自己场上存在的1只「救祓少女」超量怪兽在作为对象的自己怪兽上面重叠当作超量召唤从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--エクソシスター・アーメント
function c4408198.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,4408198+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCost(c4408198.cost)
	e1:SetCondition(c4408198.condition)
	e1:SetTarget(c4408198.target)
	e1:SetOperation(c4408198.activate)
	c:RegisterEffect(e1)
end
function c4408198.checkfilter(c)
	return c:IsSummonLocation(LOCATION_GRAVE)
end
function c4408198.condition(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c4408198.checkfilter,tp,0,LOCATION_MZONE,1,nil) then return true end
	return Duel.GetTurnPlayer()~=tp
end
function c4408198.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c4408198.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c4408198.spfilter1(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x172)
		and Duel.IsExistingMatchingCard(c4408198.spfilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
end
function c4408198.spfilter2(c,e,tp,mc)
	return c:IsType(TYPE_XYZ) and c:IsSetCard(0x172) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
		and not Duel.IsExistingMatchingCard(c4408198.cfilter,tp,LOCATION_ONFIELD,0,1,nil,c:GetCode())
end
function c4408198.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c4408198.spfilter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c4408198.spfilter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c4408198.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c4408198.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not aux.MustMaterialCheck(tc,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c4408198.spfilter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
