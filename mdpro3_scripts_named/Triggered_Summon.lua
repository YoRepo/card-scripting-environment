--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 诱发召唤  (ID: 96148285)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方场上有怪兽特殊召唤时才能发动。双方可以从手卡把1只4星以下的怪兽在场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--誘発召喚
function c96148285.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c96148285.condition)
	e1:SetOperation(c96148285.activate)
	c:RegisterEffect(e1)
end
function c96148285.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,1-tp)
end
function c96148285.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c96148285.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local g=Duel.GetMatchingGroup(c96148285.filter,tp,LOCATION_HAND,0,nil,e,tp)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(96148285,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local tc=g:Select(tp,1,1,nil):GetFirst()
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE,1-tp)>0 then
		local g=Duel.GetMatchingGroup(c96148285.filter,1-tp,LOCATION_HAND,0,nil,e,1-tp)
		if g:GetCount()>0 and Duel.SelectYesNo(1-tp,aux.Stringid(96148285,0)) then
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
			local tc=g:Select(1-tp,1,1,nil):GetFirst()
			Duel.SpecialSummonStep(tc,0,1-tp,1-tp,false,false,POS_FACEUP)
		end
	end
	Duel.SpecialSummonComplete()
end
