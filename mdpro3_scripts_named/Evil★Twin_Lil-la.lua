--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 邪恶★双子 璃拉  (ID: 36609518)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Fiend
-- ATK 1100 | LINK
-- Setcode: 22225233
--
-- Effect Text:
-- 包含「璃拉」怪兽的怪兽2只
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡特殊召唤的场合，若自己场上有「姬丝基勒」怪兽存在，以场上1张卡为对象才能发动。那张卡破坏。
-- ②：自己·对方的主要阶段，自己场上没有「姬丝基勒」怪兽存在的场合才能发动。从自己墓地把1只「姬丝基勒」怪兽特殊召唤。这个回合，自己不是恶魔族怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--Evil★Twin リィラ
function c36609518.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c36609518.lcheck)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36609518,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_ACTIVATE_CONDITION)
	e1:SetCountLimit(1,36609518)
	e1:SetCondition(c36609518.descon)
	e1:SetTarget(c36609518.destg)
	e1:SetOperation(c36609518.desop)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(36609518,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,TIMING_MAIN_END)
	e2:SetCountLimit(1,36609519)
	e2:SetCondition(c36609518.spcon)
	e2:SetTarget(c36609518.sptg)
	e2:SetOperation(c36609518.spop)
	c:RegisterEffect(e2)
end
function c36609518.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0x153)
end
function c36609518.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x152)
end
function c36609518.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c36609518.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c36609518.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c36609518.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c36609518.spcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
		and not Duel.IsExistingMatchingCard(c36609518.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c36609518.spfilter(c,e,tp)
	return c:IsSetCard(0x152) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c36609518.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c36609518.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c36609518.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c36609518.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c36609518.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c36609518.splimit(e,c)
	return not c:IsRace(RACE_FIEND) and c:IsLocation(LOCATION_EXTRA)
end
