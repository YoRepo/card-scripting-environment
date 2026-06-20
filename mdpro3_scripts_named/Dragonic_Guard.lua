--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 龙神守卫  (ID: 78009994)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dragon
-- Level 4
-- ATK 1500 | DEF 1800
--
-- Effect Text:
-- 每次怪兽通常召唤，给这张卡放置1个龙神指示物。此外，可以把场上表侧表示存在的这张卡送去墓地，把持有这张卡放置的龙神指示物数量以下的等级的1只龙族怪兽从自己卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ドラゴニック・ガード
function c78009994.initial_effect(c)
	c:EnableCounterPermit(0x22)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c78009994.ctop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_MSET)
	c:RegisterEffect(e2)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(78009994,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c78009994.spcost)
	e2:SetTarget(c78009994.sptg)
	e2:SetOperation(c78009994.spop)
	c:RegisterEffect(e2)
end
function c78009994.ctop(e,tp,eg,ep,ev,re,r,rp)
	if eg:GetFirst()~=e:GetHandler() then
		e:GetHandler():AddCounter(0x22,1)
	end
end
function c78009994.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	e:SetLabel(e:GetHandler():GetCounter(0x22))
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c78009994.spfilter(c,lv,e,tp)
	return c:IsLevelBelow(lv) and c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c78009994.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c78009994.spfilter,tp,LOCATION_DECK,0,1,nil,e:GetHandler():GetCounter(0x22),e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c78009994.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c78009994.spfilter,tp,LOCATION_DECK,0,1,1,nil,e:GetLabel(),e,tp)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
