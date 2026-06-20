--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 电子独角仙  (ID: 30587695)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Insect
-- Level 4
-- ATK 1600 | DEF 900
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：把自己场上1张表侧表示的魔法·陷阱卡送去墓地，以自己墓地1只4星以下的昆虫族怪兽为对象才能发动。那只昆虫族怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--カブトロン
function c30587695.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30587695,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,30587695)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c30587695.spcost)
	e1:SetTarget(c30587695.sptg)
	e1:SetOperation(c30587695.spop)
	c:RegisterEffect(e1)
end
function c30587695.cfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP) and Duel.GetMZoneCount(tp,c)>0 and c:IsAbleToGraveAsCost()
end
function c30587695.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30587695.cfilter,tp,LOCATION_ONFIELD,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c30587695.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c30587695.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_INSECT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c30587695.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c30587695.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c30587695.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c30587695.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c30587695.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsRace(RACE_INSECT) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
