--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 万华镜-华丽的分身-  (ID: 90219263)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：场上有「鹰身女郎」存在的场合才能发动。从手卡·卡组把1只「鹰身女郎」或「鹰身女郎三姐妹」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--万華鏡－華麗なる分身－
function c90219263.initial_effect(c)
	aux.AddCodeList(c,12206212)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c90219263.condition)
	e1:SetTarget(c90219263.target)
	e1:SetOperation(c90219263.activate)
	c:RegisterEffect(e1)
end
function c90219263.cfilter(c)
	return c:IsFaceup() and c:IsCode(76812113)
end
function c90219263.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c90219263.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c90219263.filter(c,e,tp)
	return c:IsCode(76812113,12206212) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c90219263.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90219263.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c90219263.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90219263.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)~=0 then
		tc:CompleteProcedure()
	end
end
