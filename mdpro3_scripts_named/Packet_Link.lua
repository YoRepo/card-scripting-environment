--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 分组连接  (ID: 78859567)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己·对方的主要阶段2才能发动。选自己的手卡·卡组·墓地的2星以下的怪兽任意数量在作为场上的连接怪兽所连接区的自己场上特殊召唤（同名卡最多1张）。
--[[ __CARD_HEADER_END__ ]]

--パケットリンク
function c78859567.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,78859567+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c78859567.condition)
	e1:SetTarget(c78859567.target)
	e1:SetOperation(c78859567.activate)
	c:RegisterEffect(e1)
end
function c78859567.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c78859567.filter(c,e,tp)
	return c:IsLevelBelow(2) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c78859567.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local zone=Duel.GetLinkedZone(tp)
		local ct=Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)
		return ct>0 and Duel.IsExistingMatchingCard(c78859567.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c78859567.activate(e,tp,eg,ep,ev,re,r,rp)
	local zone=Duel.GetLinkedZone(tp)
	local ct=Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)
	if ct<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ct=1 end
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c78859567.filter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:SelectSubGroup(tp,aux.dncheck,false,1,ct)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
