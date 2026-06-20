--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 与艾克佐迪亚的契约  (ID: 33244944)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 222
--
-- Effect Text:
-- ①：自己墓地有「被封印的艾克佐迪亚」「被封印者的右腕」「被封印者的左腕」「被封印者的右足」「被封印者的左足」存在的场合才能发动。从手卡把1只「艾克佐迪亚的亡灵」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--エクゾディアとの契約
function c33244944.initial_effect(c)
	aux.AddCodeList(c,8124921,44519536,70903634,7902349,33396948)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c33244944.condition)
	e1:SetTarget(c33244944.target)
	e1:SetOperation(c33244944.activate)
	c:RegisterEffect(e1)
end
function c33244944.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,8124921)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,44519536)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,70903634)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,7902349)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,33396948)
end
function c33244944.filter(c,e,tp)
	return c:IsCode(12600382) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c33244944.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33244944.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c33244944.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c33244944.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
