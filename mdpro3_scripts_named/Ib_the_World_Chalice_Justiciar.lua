--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 星杯的神子 夏娃  (ID: 94677445)
-- Type: Monster / Effect / Tuner / Synchro
-- Attribute: WATER
-- Race: Spellcaster
-- Level 5
-- ATK 1800 | DEF 2100
-- Setcode: 253
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这张卡同调召唤的场合，可以把自己场上1只「星杯」通常怪兽当作调整使用。这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡同调召唤的场合才能发动。从卡组把1张「星遗物」卡加入手卡。
-- ②：同调召唤的这张卡被送去墓地的场合才能发动。从自己的卡组·墓地把「星杯的神子 夏娃」以外的1只「星杯」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--星杯の神子イヴ
function c94677445.initial_effect(c)
	--synchro summon
	c:EnableReviveLimit()
	aux.AddSynchroMixProcedure(c,c94677445.matfilter1,nil,nil,aux.NonTuner(nil),1,99)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(94677445,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,94677445)
	e1:SetCondition(c94677445.thcon)
	e1:SetTarget(c94677445.thtg)
	e1:SetOperation(c94677445.thop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(94677445,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,94677446)
	e2:SetCondition(c94677445.spcon)
	e2:SetTarget(c94677445.sptg)
	e2:SetOperation(c94677445.spop)
	c:RegisterEffect(e2)
end
function c94677445.matfilter1(c,syncard)
	return c:IsTuner(syncard) or (c:IsSynchroType(TYPE_NORMAL) and c:IsSetCard(0xfd))
end
function c94677445.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c94677445.thfilter(c)
	return c:IsSetCard(0xfe) and c:IsAbleToHand()
end
function c94677445.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c94677445.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c94677445.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c94677445.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c94677445.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c94677445.spfilter(c,e,tp)
	return c:IsSetCard(0xfd) and not c:IsCode(94677445) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c94677445.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c94677445.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c94677445.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c94677445.spfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
