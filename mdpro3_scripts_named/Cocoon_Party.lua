--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 茧状体派对  (ID: 80368942)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己墓地存在的名字带有「新空间侠」的怪兽每有1种类，把1只名字带有「茧状体」的怪兽从自己卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--コクーン・パーティ
function c80368942.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c80368942.target)
	e1:SetOperation(c80368942.activate)
	c:RegisterEffect(e1)
end
function c80368942.gfilter(c)
	return c:IsSetCard(0x1f) and c:IsType(TYPE_MONSTER)
end
function c80368942.spfilter(c,e,tp)
	return c:IsSetCard(0x1e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c80368942.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetMatchingGroup(c80368942.gfilter,tp,LOCATION_GRAVE,0,nil)
		local ct=c80368942.count_unique_code(g)
		e:SetLabel(ct)
		return ct>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct
			and Duel.IsExistingMatchingCard(c80368942.spfilter,tp,LOCATION_DECK,0,ct,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,e:GetLabel(),tp,LOCATION_DECK)
end
function c80368942.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c80368942.gfilter,tp,LOCATION_GRAVE,0,nil)
	local ct=c80368942.count_unique_code(g)
	if ct==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<ct then return end
	local sg=Duel.GetMatchingGroup(c80368942.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if sg:GetCount()<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local spg=sg:Select(tp,ct,ct,nil)
	Duel.SpecialSummon(spg,0,tp,tp,false,false,POS_FACEUP)
end
function c80368942.count_unique_code(g)
	local check={}
	local count=0
	local tc=g:GetFirst()
	while tc do
		for i,code in ipairs({tc:GetCode()}) do
			if not check[code] then
				check[code]=true
				count=count+1
			end
		end
		tc=g:GetNext()
	end
	return count
end
