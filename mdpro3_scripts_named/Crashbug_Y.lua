--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 漏洞人Y  (ID: 23915499)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1400 | DEF 1600
--
-- Effect Text:
-- 这张卡召唤成功时，自己场上有「漏洞人Z」表侧表示存在的场合，可以从自己卡组把1只「漏洞人X」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--バグマンY
function c23915499.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23915499,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c23915499.condition)
	e1:SetTarget(c23915499.target)
	e1:SetOperation(c23915499.operation)
	c:RegisterEffect(e1)
end
function c23915499.cfilter(c)
	return c:IsFaceup() and c:IsCode(50319138)
end
function c23915499.spfilter(c,e,tp)
	return c:IsCode(87526784) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c23915499.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c23915499.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c23915499.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c23915499.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c23915499.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsExistingMatchingCard(c23915499.cfilter,tp,LOCATION_ONFIELD,0,1,nil) then return end
	local tc=Duel.GetFirstMatchingCard(c23915499.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
