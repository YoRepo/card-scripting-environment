--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 攻击反射装置  (ID: 91989718)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上1只「电子龙」作为祭品才能发动。从自己的手卡·卡组特殊召唤1只「电子障壁龙」。
--[[ __CARD_HEADER_END__ ]]

--アタック・リフレクター・ユニット
function c91989718.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c91989718.cost)
	e1:SetTarget(c91989718.target)
	e1:SetOperation(c91989718.activate)
	c:RegisterEffect(e1)
end
function c91989718.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,70095154) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,70095154)
	Duel.Release(g,REASON_COST)
end
function c91989718.spfilter(c,e,tp)
	return c:IsCode(68774379) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c91989718.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c91989718.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c91989718.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c91989718.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end
