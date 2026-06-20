--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 武神-倭  (ID: 32339440)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level 4
-- ATK 1800 | DEF 200
-- Setcode: 136
--
-- Effect Text:
-- ①：「武神-倭」在自己场上只能有1只表侧表示存在。
-- ②：自己结束阶段才能发动。从卡组把1只「武神」怪兽加入手卡。那之后，选自己1张手卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--武神－ヤマト
function c32339440.initial_effect(c)
	c:SetUniqueOnField(1,0,32339440)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32339440,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c32339440.thcon)
	e1:SetTarget(c32339440.thtg)
	e1:SetOperation(c32339440.thop)
	c:RegisterEffect(e1)
end
function c32339440.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c32339440.filter(c)
	return c:IsSetCard(0x88) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c32339440.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c32339440.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c32339440.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c32339440.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoHand(g,nil,REASON_EFFECT)>0 then
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleHand(tp)
		Duel.BreakEffect()
		Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT)
	end
end
