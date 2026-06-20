--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 电子地平线  (ID: 63031396)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 1083375764
--
-- Effect Text:
-- 这个卡名在规则上也当作「电子暗黑」卡使用。这个卡名的卡在1回合只能发动1张，这张卡发动的回合，自己不是机械族怪兽不能从额外卡组特殊召唤。
-- ①：从手卡以及卡组各把1只龙族·机械族的「电子」怪兽送去墓地才能发动（相同属性最多1只）。从卡组把1只龙族·机械族的「电子」怪兽加入手卡，从额外卡组把1只机械族「电子」融合怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--サイバネティック・ホライゾン
function c63031396.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,63031396+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c63031396.cost)
	e1:SetTarget(c63031396.target)
	e1:SetOperation(c63031396.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(63031396,ACTIVITY_SPSUMMON,c63031396.counterfilter)
end
function c63031396.counterfilter(c)
	return not c:IsSummonLocation(LOCATION_EXTRA) or c:IsRace(RACE_MACHINE)
end
function c63031396.costfilter(c)
	return c:IsRace(RACE_DRAGON+RACE_MACHINE) and c:IsSetCard(0x93) and c:IsAbleToGraveAsCost()
end
function c63031396.thfilter(c)
	return c:IsRace(RACE_DRAGON+RACE_MACHINE) and c:IsSetCard(0x93) and c:IsAbleToHand()
end
function c63031396.fselect(g,tp)
	local sg=g:Clone()
	local res=true
	for c in aux.Next(sg) do
		res=res and not sg:IsExists(Card.IsAttribute,1,c,c:GetAttribute())
	end
	return g:GetClassCount(Card.GetLocation)==g:GetCount() and res and Duel.IsExistingMatchingCard(c63031396.thfilter,tp,LOCATION_DECK,0,1,g)
end
function c63031396.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c63031396.costfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	if chk==0 then return Duel.GetCustomActivityCount(63031396,tp,ACTIVITY_SPSUMMON)==0
		and g:CheckSubGroup(c63031396.fselect,2,2,tp) end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c63031396.splimit)
	Duel.RegisterEffect(e1,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroup(tp,c63031396.fselect,false,2,2,tp)
	Duel.SendtoGrave(sg,REASON_COST)
end
function c63031396.splimit(e,c)
	return c:IsLocation(LOCATION_EXTRA) and not c:IsRace(RACE_MACHINE)
end
function c63031396.tgfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsSetCard(0x93) and c:IsType(TYPE_FUSION) and c:IsAbleToGrave()
end
function c63031396.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c63031396.thfilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(c63031396.tgfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
end
function c63031396.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=Duel.SelectMatchingCard(tp,c63031396.thfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 then
		Duel.ConfirmCards(1-tp,tc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c63031396.tgfilter,tp,LOCATION_EXTRA,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoGrave(g,REASON_EFFECT)
		end
	end
end
