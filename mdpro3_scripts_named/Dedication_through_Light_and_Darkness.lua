--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 光与暗之洗礼  (ID: 69542930)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：把自己场上1只「黑魔术师」解放才能发动。从自己的手卡·卡组·墓地选1只「混沌之黑魔术师」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--光と闇の洗礼
function c69542930.initial_effect(c)
	aux.AddCodeList(c,46986414)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c69542930.cost)
	e1:SetTarget(c69542930.target)
	e1:SetOperation(c69542930.activate)
	c:RegisterEffect(e1)
end
function c69542930.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,46986414) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,46986414)
	Duel.Release(g,REASON_COST)
end
function c69542930.filter(c,e,tp)
	return c:IsCode(40737112) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c69542930.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c69542930.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c69542930.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c69542930.filter),tp,0x13,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
