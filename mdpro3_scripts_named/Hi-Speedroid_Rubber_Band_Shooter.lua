--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 高速疾行机人 GOM枪  (ID: 72813401)
-- Type: Monster / Effect / Link
-- Attribute: WIND
-- Race: Machine
-- ATK 1000 | LINK
-- Setcode: 8214
--
-- Effect Text:
-- 风属性怪兽2只
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。进行1只风属性怪兽的召唤。这个回合，自己不是同调怪兽不能从额外卡组特殊召唤。
-- ②：从额外卡组把1只风属性同调怪兽除外才能发动。等级合计直到变成和除外的怪兽相同为止，从卡组把2只卡名不同的「疾行机人」怪兽给对方观看，对方从那之中随机选1只。那1只怪兽加入自己手卡，剩余送去墓地。
--[[ __CARD_HEADER_END__ ]]

--HSR－GOMガン
function c72813401.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkAttribute,ATTRIBUTE_WIND),2,2)
	c:EnableReviveLimit()
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(72813401,0))
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,72813401)
	e1:SetTarget(c72813401.sumtg)
	e1:SetOperation(c72813401.sumop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(72813401,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,72813402)
	e2:SetTarget(c72813401.thtg)
	e2:SetOperation(c72813401.thop)
	c:RegisterEffect(e2)
end
function c72813401.sumfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsSummonable(true,nil)
end
function c72813401.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72813401.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c72813401.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c72813401.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c72813401.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c72813401.splimit(e,c)
	return not c:IsType(TYPE_SYNCHRO) and c:IsLocation(LOCATION_EXTRA)
end
function c72813401.costfilter(c,g)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsType(TYPE_SYNCHRO) and c:IsAbleToRemoveAsCost()
		and g:IsExists(c72813401.thfilter1,1,nil,g,c:GetLevel())
end
function c72813401.thfilter1(c,g,lv)
	return g:IsExists(c72813401.thfilter2,1,c,c,lv)
end
function c72813401.thfilter2(c,mc,lv)
	return not c:IsCode(mc:GetCode()) and c:GetLevel()+mc:GetLevel()==lv
end
function c72813401.thfilter(c)
	return c:IsSetCard(0x2016) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c72813401.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c72813401.thfilter,tp,LOCATION_DECK,0,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(c72813401.costfilter,tp,LOCATION_EXTRA,0,1,nil,g) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=Duel.SelectMatchingCard(tp,c72813401.costfilter,tp,LOCATION_EXTRA,0,1,1,nil,g)
	e:SetLabel(sg:GetFirst():GetLevel())
	Duel.Remove(sg,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c72813401.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c72813401.thfilter,tp,LOCATION_DECK,0,nil)
	local lv=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,c72813401.thfilter1,1,1,nil,g,lv)
	if #sg>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg2=g:FilterSelect(tp,c72813401.thfilter2,1,1,sg:GetFirst(),sg:GetFirst(),lv)
		sg:Merge(sg2)
		Duel.ConfirmCards(1-tp,sg)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local tg=sg:RandomSelect(1-tp,1)
		tg:GetFirst():SetStatus(STATUS_TO_HAND_WITHOUT_CONFIRM,true)
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		sg:Sub(tg)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
