--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 恶魔降临  (ID: 95825679)
-- Type: Monster / Effect / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 2500 | DEF 1200
-- Setcode: 69
--
-- Effect Text:
-- 「与奈落的契约」降临。
-- ①：这张卡只要在怪兽区域存在，卡名当作「恶魔召唤」使用。
-- ②：场上的这张卡不会被和仪式怪兽以外的怪兽的战斗破坏，不会被仪式怪兽以外的怪兽的效果破坏。
-- ③：仪式召唤的这张卡被对方送去墓地的场合才能发动。从自己的手卡·卡组·墓地选1只「恶魔召唤」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--デーモンの降臨
function c95825679.initial_effect(c)
	aux.AddCodeList(c,69035382)
	c:EnableReviveLimit()
	--code
	aux.EnableChangeCode(c,70781052)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c95825679.indval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(c95825679.indeval)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(c95825679.spcon)
	e4:SetTarget(c95825679.sptg)
	e4:SetOperation(c95825679.spop)
	c:RegisterEffect(e4)
end
function c95825679.indval(e,c)
	return not c:IsType(TYPE_RITUAL)
end
function c95825679.indeval(e,re,rp)
	return re:IsActiveType(TYPE_MONSTER) and not re:IsActiveType(TYPE_RITUAL)
end
function c95825679.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_RITUAL)
		and rp==1-tp and c:IsPreviousControler(tp)
end
function c95825679.spfilter(c,e,tp)
	return c:IsCode(70781052) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c95825679.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c95825679.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c95825679.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c95825679.spfilter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
