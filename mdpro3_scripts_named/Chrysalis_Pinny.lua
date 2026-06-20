--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 茧状体·小松茸  (ID: 29246354)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Plant
-- Level 2
-- ATK 100 | DEF 700
-- Setcode: 30
--
-- Effect Text:
-- 场上有「新宇宙」存在时，可以把这张卡作为祭品从手卡·卡组特殊召唤1只「新空间侠·光辉青苔」。
--[[ __CARD_HEADER_END__ ]]

--C・ピニー
function c29246354.initial_effect(c)
	aux.AddCodeList(c,17732278)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29246354,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c29246354.spcon)
	e1:SetCost(c29246354.spcost)
	e1:SetTarget(c29246354.sptg)
	e1:SetOperation(c29246354.spop)
	c:RegisterEffect(e1)
end
function c29246354.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(42015635)
end
function c29246354.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c29246354.spfilter(c,e,tp)
	return c:IsCode(17732278) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29246354.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c29246354.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c29246354.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsEnvironment(42015635) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c29246354.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
