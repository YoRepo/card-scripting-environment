--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 雷-鸣  (ID: 63223467)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 3
-- ATK 1400 | DEF 1200
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，可以从自己卡组把1只2星以下的光属性怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--RAI－MEI
function c63223467.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63223467,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c63223467.condition)
	e1:SetTarget(c63223467.target)
	e1:SetOperation(c63223467.operation)
	c:RegisterEffect(e1)
end
function c63223467.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c63223467.filter(c)
	return c:IsLevelBelow(2) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToHand()
end
function c63223467.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c63223467.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c63223467.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c63223467.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
