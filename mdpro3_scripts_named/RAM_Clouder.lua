--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: RAM云雄羊  (ID: 9190563)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level 4
-- ATK 1800 | DEF 1000
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：把自己场上1只怪兽解放，以自己墓地1只电子界族怪兽为对象才能发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--RAMクラウダー
function c9190563.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9190563,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,9190563)
	e1:SetCost(c9190563.spcost)
	e1:SetTarget(c9190563.sptg)
	e1:SetOperation(c9190563.spop)
	c:RegisterEffect(e1)
end
function c9190563.cfilter(c,ft,tp)
	return ft>0 or (c:IsControler(tp) and c:GetSequence()<5)
end
function c9190563.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.CheckReleaseGroup(tp,c9190563.cfilter,1,nil,ft,tp) end
	local g=Duel.SelectReleaseGroup(tp,c9190563.cfilter,1,1,nil,ft,tp)
	Duel.Release(g,REASON_COST)
end
function c9190563.spfilter(c,e,tp)
	return c:IsRace(RACE_CYBERSE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c9190563.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c9190563.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c9190563.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c9190563.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetFirst()==e:GetHandler() then
		e:GetHandler():ReleaseEffectRelation(e)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c9190563.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsRelateToChain() or (tc==c and c:IsLocation(LOCATION_GRAVE) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetReasonEffect()==e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
