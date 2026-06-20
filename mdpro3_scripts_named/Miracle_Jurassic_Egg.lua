--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 奇迹之侏罗纪蛋  (ID: 63259351)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 4
-- ATK 0 | DEF 2000
--
-- Effect Text:
-- ①：场上的表侧表示的这张卡不能除外。
-- ②：只要这张卡在怪兽区域存在，每次恐龙族怪兽被送去自己墓地，给这张卡放置2个指示物。
-- ③：把这张卡解放才能发动。把持有这张卡放置的指示物数量以下的等级的1只恐龙族怪兽从卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--奇跡のジュラシック・エッグ
function c63259351.initial_effect(c)
	c:EnableCounterPermit(0x14)
	--cannot remove
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CANNOT_REMOVE)
	e1:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c63259351.ctop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetDescription(aux.Stringid(63259351,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c63259351.spcost)
	e3:SetTarget(c63259351.sptg)
	e3:SetOperation(c63259351.spop)
	c:RegisterEffect(e3)
end
function c63259351.ctfilter(c,tp)
	return c:IsControler(tp) and c:IsRace(RACE_DINOSAUR)
end
function c63259351.ctop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c63259351.ctfilter,1,nil,tp) then
		e:GetHandler():AddCounter(0x14,2)
	end
end
function c63259351.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	e:SetLabel(e:GetHandler():GetCounter(0x14))
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c63259351.spfilter(c,lv,e,tp)
	return c:IsLevelBelow(lv) and c:IsRace(RACE_DINOSAUR) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c63259351.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>0
		and Duel.IsExistingMatchingCard(c63259351.spfilter,tp,LOCATION_DECK,0,1,nil,e:GetHandler():GetCounter(0x14),e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c63259351.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c63259351.spfilter,tp,LOCATION_DECK,0,1,1,nil,e:GetLabel(),e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
