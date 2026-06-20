--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 银河眼云笼  (ID: 9260791)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 1
-- ATK 300 | DEF 250
-- Setcode: 4219
--
-- Effect Text:
-- 把这张卡解放才能发动。从自己的手卡·墓地选「银河眼云笼」以外的1只名字带有「银河眼」的怪兽特殊召唤。「银河眼云笼」的这个效果1回合只能使用1次。此外，这张卡在墓地存在的场合，自己的主要阶段时选择自己场
-- 上1只名字带有「银河眼」的超量怪兽才能发动。把墓地的这张卡在选择的怪兽下面重叠作为超量素材。「银河眼云笼」的这个效果在决斗中只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--銀河眼の雲篭
function c9260791.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9260791,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,9260791)
	e1:SetCost(c9260791.spcost)
	e1:SetTarget(c9260791.sptg)
	e1:SetOperation(c9260791.spop)
	c:RegisterEffect(e1)
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9260791,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,9260791+EFFECT_COUNT_CODE_DUEL)
	e2:SetTarget(c9260791.target)
	e2:SetOperation(c9260791.operation)
	c:RegisterEffect(e2)
end
function c9260791.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c9260791.spfilter(c,e,tp)
	return c:IsSetCard(0x107b) and not c:IsCode(9260791) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c9260791.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c9260791.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c9260791.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c9260791.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c9260791.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x107b) and c:IsType(TYPE_XYZ)
end
function c9260791.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c9260791.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c9260791.filter,tp,LOCATION_MZONE,0,1,nil)
		and e:GetHandler():IsCanOverlay() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c9260791.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c9260791.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
