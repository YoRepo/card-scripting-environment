--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 秘学家  (ID: 22171591)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Psychic
-- Level 1
-- ATK 100 | DEF 100
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，可以支付800基本分从自己卡组把1只念动力族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--カバリスト
function c22171591.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22171591,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c22171591.condition)
	e1:SetCost(c22171591.cost)
	e1:SetTarget(c22171591.target)
	e1:SetOperation(c22171591.operation)
	c:RegisterEffect(e1)
end
function c22171591.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c22171591.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c22171591.filter(c)
	return c:IsRace(RACE_PSYCHO) and c:IsAbleToHand()
end
function c22171591.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22171591.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c22171591.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c22171591.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
