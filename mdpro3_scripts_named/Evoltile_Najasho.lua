--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 进化虫·圣诱蛇  (ID: 88095331)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Reptile
-- Level 2
-- ATK 100 | DEF 2000
-- Setcode: 12366
--
-- Effect Text:
-- 场上的这张卡被解放的场合，可以从卡组把1只名字带有「进化龙」的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--エヴォルド・ナハシュ
function c88095331.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88095331,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_RELEASE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c88095331.condition)
	e1:SetTarget(c88095331.target)
	e1:SetOperation(c88095331.operation)
	c:RegisterEffect(e1)
end
function c88095331.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c88095331.filter(c,e,tp)
	return c:IsSetCard(0x604e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c88095331.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c88095331.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c88095331.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c88095331.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
