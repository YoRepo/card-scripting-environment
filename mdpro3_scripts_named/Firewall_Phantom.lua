--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 防火幻影  (ID: 57940938)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Cyberse
-- Level 5
-- ATK 2000 | DEF 1300
-- Setcode: 399
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡作为电子界族连接怪兽的连接素材送去墓地的场合才能发动。从卡组把1张「电脑网」魔法·陷阱卡加入手卡。那之后，选自己1张手卡丢弃。
-- ②：把墓地的这张卡除外才能发动。这个回合的结束阶段，从自己墓地让1只电子界族怪兽回到卡组。
--[[ __CARD_HEADER_END__ ]]

--ファイアウォール・ファントム
function c57940938.initial_effect(c)
	--Search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,57940938)
	e1:SetCondition(c57940938.thcon)
	e1:SetTarget(c57940938.thtg)
	e1:SetOperation(c57940938.thop)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_GRAVE_ACTION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,57940939)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(c57940938.op)
	c:RegisterEffect(e2)
end
function c57940938.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_LINK and rc:IsRace(RACE_CYBERSE)
end
function c57940938.thfilter(c)
	return c:IsSetCard(0x118) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c57940938.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c57940938.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c57940938.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c57940938.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoHand(g,nil,REASON_EFFECT)~=0 and g:GetFirst():IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,g)
		Duel.BreakEffect()
		Duel.ShuffleHand(tp)
		Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD,nil)
	end
end
function c57940938.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c57940938.tdcon)
	e1:SetOperation(c57940938.tdop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c57940938.tdfilter(c)
	return c:IsRace(RACE_CYBERSE) and c:IsAbleToDeck()
end
function c57940938.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c57940938.tdfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c57940938.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,57940938)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c57940938.tdfilter),tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
