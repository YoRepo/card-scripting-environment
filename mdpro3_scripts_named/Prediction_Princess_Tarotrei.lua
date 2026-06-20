--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 圣占术姬 塔罗光巫女  (ID: 94997874)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Fairy
-- Level 9
-- ATK 2700 | DEF 1200
-- Setcode: 204
--
-- Effect Text:
-- 「圣占术的仪式」降临。这个卡名的①②的效果1回合只能有1次使用其中任意1个，对方回合也能发动。
-- ①：以场上1只里侧表示怪兽为对象才能发动。那只怪兽变成表侧攻击表示。
-- ②：以场上1只表侧表示怪兽为对象才能发动。那只怪兽变成里侧守备表示。
-- ③：自己结束阶段才能发动。从自己的手卡·墓地选1只反转怪兽里侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--聖占術姫タロットレイ
function c94997874.initial_effect(c)
	aux.AddCodeList(c,30392583)
	c:EnableReviveLimit()
	--position change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(94997874,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_END_PHASE,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE+TIMING_STANDBY_PHASE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,94997874)
	e1:SetTarget(c94997874.postg)
	e1:SetOperation(c94997874.posop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(94997874,1))
	e2:SetTarget(c94997874.postg2)
	e2:SetOperation(c94997874.posop2)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(94997874,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c94997874.spcon)
	e3:SetTarget(c94997874.sptg)
	e3:SetOperation(c94997874.spop)
	c:RegisterEffect(e3)
end
function c94997874.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c94997874.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
	end
end
function c94997874.posfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c94997874.postg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c94997874.posfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c94997874.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c94997874.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c94997874.posop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end
function c94997874.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c94997874.spfilter(c,e,tp)
	local proc=c:IsCode(42932862) and e:GetHandler():IsCode(94997874)
	return c:IsType(TYPE_FLIP) and c:IsCanBeSpecialSummoned(e,0,tp,proc,proc,POS_FACEDOWN_DEFENSE)
end
function c94997874.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c94997874.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c94997874.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c94997874.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		local proc=tc:IsCode(42932862) and e:GetHandler():IsCode(94997874)
		Duel.SpecialSummon(tc,0,tp,tp,proc,proc,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,tc)
		if proc then tc:CompleteProcedure() end
	end
end
