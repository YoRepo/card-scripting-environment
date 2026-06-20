--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 卡通翻阅  (ID: 27699122)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 98
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上有「卡通世界」存在的场合才能发动。从卡组把3只卡名不同的卡通怪兽给对方观看，对方从那之中随机选1只。那1只怪兽无视召唤条件在自己场上特殊召唤。剩下的怪兽回到卡组。
--[[ __CARD_HEADER_END__ ]]

--トゥーン・フリップ
function c27699122.initial_effect(c)
	aux.AddCodeList(c,15259703)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,27699122+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c27699122.con)
	e1:SetTarget(c27699122.tg)
	e1:SetOperation(c27699122.op)
	c:RegisterEffect(e1)
end
function c27699122.ffilter(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c27699122.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c27699122.ffilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c27699122.filter(c,e,tp)
	return c:IsType(TYPE_TOON) and c:IsCanBeSpecialSummoned(e,0,tp,true,false,POS_FACEUP)
end
function c27699122.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local dg=Duel.GetMatchingGroup(c27699122.filter,tp,LOCATION_DECK,0,nil,e,tp)
		return dg:GetClassCount(Card.GetCode)>=3 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c27699122.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c27699122.filter,tp,LOCATION_DECK,0,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or g:GetClassCount(Card.GetCode)<3 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,3,3)
	if sg then
		Duel.ConfirmCards(1-tp,sg)
		local tc=sg:RandomSelect(1-tp,1):GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
end
