--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 六花圣 花簪剑菊  (ID: 6284176)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Plant
-- Rank 6
-- ATK 2400 | DEF 2400
-- Setcode: 321
--
-- Effect Text:
-- 6星怪兽×2
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：怪兽被解放的场合，把这张卡1个超量素材取除，以自己或者对方的墓地1只怪兽为对象才能发动。那只怪兽在自己场上特殊召唤。这个效果特殊召唤的怪兽效果无效化，变成植物族。
-- ②：自己场上的植物族怪兽被效果破坏的场合，可以作为代替把自己的手卡·场上1只植物族怪兽解放。
--[[ __CARD_HEADER_END__ ]]

--六花聖カンザシ
function c6284176.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6284176,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_RELEASE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,6284176)
	e1:SetCondition(c6284176.spcon)
	e1:SetCost(c6284176.spcost)
	e1:SetTarget(c6284176.sptg)
	e1:SetOperation(c6284176.spop)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,6284177)
	e2:SetTarget(c6284176.reptg)
	e2:SetValue(c6284176.repval)
	e2:SetOperation(c6284176.repop)
	c:RegisterEffect(e2)
end
function c6284176.cfilter(c)
	return (c:IsType(TYPE_MONSTER) and not c:IsPreviousLocation(LOCATION_SZONE)) or c:IsPreviousLocation(LOCATION_MZONE)
end
function c6284176.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c6284176.cfilter,1,nil) and not eg:IsContains(e:GetHandler())
end
function c6284176.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c6284176.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c6284176.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c6284176.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c6284176.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c6284176.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c6284176.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CHANGE_RACE)
		e3:SetValue(RACE_PLANT)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e3)
	end
	Duel.SpecialSummonComplete()
end
function c6284176.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsRace(RACE_PLANT) and c:IsReason(REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c6284176.rfilter(c)
	return c:IsRace(RACE_PLANT) and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c6284176.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c6284176.repfilter,1,nil,tp)
		and Duel.CheckReleaseGroupEx(tp,c6284176.rfilter,1,REASON_EFFECT,true,nil) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c6284176.repval(e,c)
	return c6284176.repfilter(c,e:GetHandlerPlayer())
end
function c6284176.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
	local g=Duel.SelectReleaseGroupEx(tp,c6284176.rfilter,1,1,REASON_EFFECT,true,nil)
	Duel.Hint(HINT_CARD,0,6284176)
	Duel.Release(g,REASON_EFFECT+REASON_REPLACE)
end
