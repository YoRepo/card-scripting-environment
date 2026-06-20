--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 进化虫·埃尔金螈  (ID: 91903221)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Reptile
-- Level 2
-- ATK 0 | DEF 0
-- Setcode: 12366
--
-- Effect Text:
-- 场上的这张卡被解放送去墓地时，从卡组抽1张卡。那之后，可以让手卡1只恐龙族怪兽回到卡组，从卡组把1只名字带有「进化虫」的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--エヴォルド・エルギネル
function c91903221.initial_effect(c)
	--draw & search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91903221,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_RELEASE)
	e1:SetCondition(c91903221.condition)
	e1:SetTarget(c91903221.target)
	e1:SetOperation(c91903221.operation)
	c:RegisterEffect(e1)
end
function c91903221.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():IsLocation(LOCATION_GRAVE)
end
function c91903221.filter1(c)
	return c:IsRace(RACE_DINOSAUR) and c:IsAbleToDeck()
end
function c91903221.filter2(c)
	return c:IsSetCard(0x304e) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c91903221.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c91903221.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local g1=Duel.GetMatchingGroup(c91903221.filter1,tp,LOCATION_HAND,0,nil)
	local g2=Duel.GetMatchingGroup(c91903221.filter2,tp,LOCATION_DECK,0,nil)
	if g1:GetCount()>0 and g2:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(91903221,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local tg1=g1:Select(tp,1,1,nil)
		Duel.ConfirmCards(1-tp,tg1)
		Duel.SendtoDeck(tg1,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local tg2=g2:Select(tp,1,1,nil)
		Duel.SendtoHand(tg2,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg2)
	end
end
