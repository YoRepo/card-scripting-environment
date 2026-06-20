--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 机甲部队·超大变形  (ID: 51617185)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 8
-- ATK 2600 | DEF 1500
-- Setcode: 54
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：把这张卡解放才能发动。从手卡·卡组把「机甲部队·超大变形」以外的1只「机甲」怪兽特殊召唤。
-- ②：这张卡在墓地存在的状态，自己场上的「机甲要塞」被送去自己墓地的场合，把那1只「机甲要塞」从墓地除外才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--マシンナーズ・メガフォーム
function c51617185.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51617185,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,51617185)
	e1:SetCost(c51617185.spcost1)
	e1:SetTarget(c51617185.sptg1)
	e1:SetOperation(c51617185.spop1)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51617185,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,51617185)
	e2:SetCost(c51617185.spcost2)
	e2:SetTarget(c51617185.sptg2)
	e2:SetOperation(c51617185.spop2)
	c:RegisterEffect(e2)
end
function c51617185.spcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c51617185.spfilter(c,e,tp)
	return c:IsSetCard(0x36) and not c:IsCode(51617185) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c51617185.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c51617185.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c51617185.spop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c51617185.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c51617185.cfilter(c,tp)
	return c:IsCode(5556499) and c:IsControler(tp)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
		and c:IsPreviousControler(tp) and c:IsAbleToRemoveAsCost()
end
function c51617185.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not eg:IsContains(e:GetHandler()) and eg:IsExists(c51617185.cfilter,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=eg:FilterSelect(tp,c51617185.cfilter,1,1,nil,tp)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c51617185.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c51617185.spop2(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
