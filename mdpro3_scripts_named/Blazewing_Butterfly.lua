--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 炎妖蝶 维尔普斯  (ID: 16984449)
-- Type: Monster / Effect / Gemini
-- Attribute: FIRE
-- Race: Insect
-- Level 4
-- ATK 1500 | DEF 1500
--
-- Effect Text:
-- ①：这张卡只要在场上·墓地存在，当作通常怪兽使用。
-- ②：可以把场上的当作通常怪兽使用的这张卡作为通常召唤作再1次召唤。那个场合这张卡变成当作效果怪兽使用并得到以下效果。
-- ●把这张卡解放，以「炎妖蝶 维尔普斯」以外的自己墓地1只二重怪兽为对象才能发动。那只怪兽特殊召唤。这个效果特殊召唤的怪兽当作再1次召唤的状态使用。
--[[ __CARD_HEADER_END__ ]]

--炎妖蝶ウィルプス
function c16984449.initial_effect(c)
	aux.EnableDualAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(16984449,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetCost(c16984449.cost)
	e1:SetTarget(c16984449.target)
	e1:SetOperation(c16984449.operation)
	c:RegisterEffect(e1)
end
function c16984449.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c16984449.filter(c,e,sp)
	return c:IsType(TYPE_DUAL) and not c:IsCode(16984449) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c16984449.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c16984449.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c16984449.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c16984449.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c16984449.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		tc:EnableDualState()
	end
	Duel.SpecialSummonComplete()
end
