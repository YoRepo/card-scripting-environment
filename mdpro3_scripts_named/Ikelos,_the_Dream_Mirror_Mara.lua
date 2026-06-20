--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 梦魔镜的梦魔-伊刻罗斯  (ID: 75888208)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level 1
-- ATK 500 | DEF 0
-- Setcode: 305
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡用「梦魔镜」怪兽的效果特殊召唤成功的场合才能发动。从手卡把「梦魔镜的梦魔-伊刻罗斯」以外的1只「梦魔镜」怪兽特殊召唤。
-- ②：场地区域有「圣光之梦魔镜」存在的场合，自己·对方的主要阶段以及战斗阶段，把这张卡解放才能发动。从卡组把1只「梦魔镜的少女-伊刻罗斯」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--夢魔鏡の夢魔－イケロス
function c75888208.initial_effect(c)
	aux.AddCodeList(c,74665651,49389190)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75888208,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,75888208)
	e1:SetCondition(c75888208.spcon1)
	e1:SetTarget(c75888208.sptg1)
	e1:SetOperation(c75888208.spop1)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75888208,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_MAIN_END+TIMING_BATTLE_START+TIMING_BATTLE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,75888209)
	e2:SetCondition(c75888208.spcon2)
	e2:SetCost(c75888208.spcost2)
	e2:SetTarget(c75888208.sptg2)
	e2:SetOperation(c75888208.spop2)
	c:RegisterEffect(e2)
end
function c75888208.spcon1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSpecialSummonInfo(SUMMON_INFO_TYPE)&TYPE_MONSTER~=0 and c:IsSpecialSummonSetCard(0x131)
end
function c75888208.spfilter1(c,e,tp)
	return c:IsSetCard(0x131) and not c:IsCode(75888208) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75888208.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75888208.spfilter1,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c75888208.spop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c75888208.spfilter1,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c75888208.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2)
		and Duel.IsEnvironment(74665651,PLAYER_ALL,LOCATION_FZONE)
end
function c75888208.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c75888208.spfilter2(c,e,tp)
	return c:IsCode(49389190) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75888208.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>0
		and Duel.IsExistingMatchingCard(c75888208.spfilter2,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c75888208.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c75888208.spfilter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
