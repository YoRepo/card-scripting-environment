--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 逢华妖丽谭-不知火语  (ID: 13965201)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 217
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：对方场上有怪兽存在的场合，从手卡丢弃1只不死族怪兽才能发动。从自己的卡组·墓地选和丢弃的怪兽卡名不同的1只「不知火」怪兽特殊召唤。这张卡的发动后，直到回合结束时自己不是不死族怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--逢華妖麗譚－不知火語
function c13965201.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,13965201+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c13965201.condition)
	e1:SetCost(c13965201.cost)
	e1:SetTarget(c13965201.target)
	e1:SetOperation(c13965201.activate)
	c:RegisterEffect(e1)
end
function c13965201.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c13965201.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return true end
end
function c13965201.costfilter(c,e,tp)
	return c:IsDiscardable() and c:IsRace(RACE_ZOMBIE)
		and Duel.IsExistingMatchingCard(c13965201.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp,c:GetCode())
end
function c13965201.spfilter(c,e,tp,code)
	return c:IsSetCard(0xd9) and c:IsType(TYPE_MONSTER)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(code)
end
function c13965201.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c13965201.costfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c13965201.costfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	e:SetLabelObject(g:GetFirst())
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c13965201.activate(e,tp,eg,ep,ev,re,r,rp)
	local dc=e:GetLabelObject()
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c13965201.spfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,nil,e,tp,dc:GetCode())
	if #g>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c13965201.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c13965201.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsRace(RACE_ZOMBIE)
end
