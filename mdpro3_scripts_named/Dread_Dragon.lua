--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 惧龙  (ID: 51925772)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Dragon
-- Level 2
-- ATK 1100 | DEF 400
--
-- Effect Text:
-- ①：这张卡被战斗破坏送去墓地时才能发动。从卡组把1只3星以下的龙族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ドレッド・ドラゴン
function c51925772.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51925772,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c51925772.condition)
	e1:SetTarget(c51925772.target)
	e1:SetOperation(c51925772.operation)
	c:RegisterEffect(e1)
end
function c51925772.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c51925772.filter(c)
	return c:IsLevelBelow(3) and c:IsRace(RACE_DRAGON) and c:IsAbleToHand()
end
function c51925772.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51925772.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c51925772.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c51925772.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
