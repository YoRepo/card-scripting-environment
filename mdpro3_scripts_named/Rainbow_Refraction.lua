--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 飞越虹桥  (ID: 40854824)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：原本卡名是「究极宝玉神 虹龙」或者「究极宝玉神 虹暗龙」的怪兽在自己场上把效果发动的回合才能发动。从卡组把「宝玉兽」怪兽任意数量特殊召唤（同名卡最多1张）。
--[[ __CARD_HEADER_END__ ]]

--オーバー・ザ・レインボー
function c40854824.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c40854824.condition)
	e1:SetTarget(c40854824.target)
	e1:SetOperation(c40854824.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(40854824,ACTIVITY_CHAIN,c40854824.chainfilter)
end
function c40854824.chainfilter(re,tp,cid)
	return not (re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsOriginalCodeRule(79407975,79856792))
end
function c40854824.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCustomActivityCount(40854824,tp,ACTIVITY_CHAIN)~=0
end
function c40854824.filter(c,e,tp)
	return c:IsSetCard(0x1034) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c40854824.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c40854824.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c40854824.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local g=Duel.GetMatchingGroup(c40854824.filter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,1,ft)
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end
