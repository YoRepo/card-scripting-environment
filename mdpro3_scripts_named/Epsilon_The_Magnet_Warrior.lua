--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 磁石战士ε  (ID: 52566270)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 4
-- ATK 1300 | DEF 1500
-- Setcode: 8294
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合，从卡组把「磁石战士ε」以外的1只4星以下的「磁石战士」怪兽送去墓地才能发动。这张卡直到结束阶段当作和送去墓地的怪兽同名卡使用。那之后，可以从自己墓地选同名卡不在自己
-- 场上存在的1只「磁石战士」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--磁石の戦士ε
function c52566270.initial_effect(c)
	--cos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52566270,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,52566270)
	e1:SetCost(c52566270.cost)
	e1:SetOperation(c52566270.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c52566270.costfilter(c)
	return c:IsSetCard(0x2066) and c:IsLevelBelow(4) and c:IsAbleToGraveAsCost() and not c:IsCode(52566270)
end
function c52566270.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c52566270.costfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local cg=Duel.SelectMatchingCard(tp,c52566270.costfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(cg,REASON_COST)
	e:SetLabel(cg:GetFirst():GetCode())
end
function c52566270.cfilter(c,oc)
	return c:IsFaceup() and c:IsCode(oc:GetCode())
end
function c52566270.spfilter(c,e,tp)
	return c:IsSetCard(0x2066,0xe9) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not Duel.IsExistingMatchingCard(c52566270.cfilter,tp,LOCATION_ONFIELD,0,1,nil,c)
end
function c52566270.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(e:GetLabel())
	c:RegisterEffect(e1)
	if Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c52566270.spfilter),tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.SelectYesNo(tp,aux.Stringid(52566270,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c52566270.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
