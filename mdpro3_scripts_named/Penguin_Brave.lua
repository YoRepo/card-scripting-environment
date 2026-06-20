--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 企鹅勇者  (ID: 91397409)
-- Type: Monster / Effect / Synchro
-- Attribute: WATER
-- Race: Aqua
-- Level 6
-- ATK 2400 | DEF 1200
-- Setcode: 90
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：这张卡同调召唤成功的场合才能发动。从卡组把1只「企鹅」怪兽里侧守备表示特殊召唤。
-- ②：只要这张卡在怪兽区域存在，自己场上的里侧守备表示怪兽不会成为对方的效果的对象。
-- ③：对方把怪兽的效果发动时才能发动。选自己场上1只里侧守备表示的水属性怪兽变成表侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--ペンギン勇者
function c91397409.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91397409,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,91397409)
	e1:SetCondition(c91397409.spcon)
	e1:SetTarget(c91397409.sptg)
	e1:SetOperation(c91397409.spop)
	c:RegisterEffect(e1)
	--can not be effect target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsPosition,POS_FACEDOWN_DEFENSE))
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--position
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(91397409,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,91397410)
	e3:SetCondition(c91397409.poscon)
	e3:SetTarget(c91397409.postg)
	e3:SetOperation(c91397409.posop)
	c:RegisterEffect(e3)
end
function c91397409.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c91397409.spfilter(c,e,tp)
	return c:IsSetCard(0x5a) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c91397409.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c91397409.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c91397409.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c91397409.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c91397409.poscon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and rp==1-tp and re:IsActiveType(TYPE_MONSTER)
end
function c91397409.posfilter(c)
	return c:IsPosition(POS_FACEDOWN_DEFENSE) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsCanChangePosition()
end
function c91397409.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c91397409.posfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c91397409.posop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectMatchingCard(tp,c91397409.posfilter,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
end
