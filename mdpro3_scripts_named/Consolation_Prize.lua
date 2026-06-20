--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 废车复活  (ID: 63413494)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己或者对方的手卡有怪兽被送去墓地的场合，以那1只怪兽为对象才能发动。那只怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--廃車復活
function c63413494.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,63413494+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c63413494.target)
	e1:SetOperation(c63413494.activate)
	c:RegisterEffect(e1)
end
function c63413494.filter(c,e,tp,g)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsPreviousLocation(LOCATION_HAND) and (not g or g:IsContains(c))
end
function c63413494.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c63413494.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c63413494.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp,eg) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c63413494.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp,eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c63413494.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
