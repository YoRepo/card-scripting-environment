--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 春化精的花盛  (ID: 7206349)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 386
--
-- Effect Text:
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：只要自己场上有地属性怪兽5只以上存在，自己场上的怪兽的攻击力上升1000。
-- ②：从自己的手卡·墓地把1张「春化精与花蕾」除外才能发动。从卡组把1只「春化精的女神 春」特殊召唤。
-- ③：从自己墓地有「春化精」怪兽特殊召唤的场合，以自己或者对方的场上·墓地1只怪兽为对象才能发动。那只怪兽回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--春化精の花盛
function c7206349.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c7206349.condition)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(7206349,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1,7206349)
	e3:SetCost(c7206349.spcost)
	e3:SetTarget(c7206349.sptg)
	e3:SetOperation(c7206349.spop)
	c:RegisterEffect(e3)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(7206349,1))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1,7206350)
	e4:SetCondition(c7206349.thcon)
	e4:SetTarget(c7206349.thtg)
	e4:SetOperation(c7206349.thop)
	c:RegisterEffect(e4)
end
function c7206349.atkfilter(c)
	return c:IsAttribute(ATTRIBUTE_EARTH) and c:IsFaceup()
end
function c7206349.condition(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(c7206349.atkfilter,tp,LOCATION_MZONE,0,nil)>=5
end
function c7206349.costfilter(c)
	return c:IsCode(63708033) and c:IsAbleToRemoveAsCost()
end
function c7206349.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c7206349.costfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c7206349.costfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c7206349.filter(c,e,tp)
	return c:IsCode(55125728) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c7206349.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c7206349.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c7206349.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c7206349.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c7206349.cfilter(c,tp)
	return c:IsSetCard(0x182) and c:IsPreviousLocation(LOCATION_GRAVE) and c:IsPreviousControler(tp)
end
function c7206349.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c7206349.cfilter,1,nil,tp)
end
function c7206349.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c7206349.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_MZONE) and c7206349.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c7206349.thfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_GRAVE+LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=aux.SelectTargetFromFieldFirst(tp,c7206349.thfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_GRAVE+LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c7206349.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
