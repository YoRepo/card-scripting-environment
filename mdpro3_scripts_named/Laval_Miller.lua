--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 推炎车的熔岩人  (ID: 89893715)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 3
-- ATK 300 | DEF 400
-- Setcode: 57
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，可以从自己卡组选择2只名字带有「熔岩」的怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ラヴァルの炎車回し
function c89893715.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89893715,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c89893715.condition)
	e1:SetTarget(c89893715.target)
	e1:SetOperation(c89893715.operation)
	c:RegisterEffect(e1)
end
function c89893715.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c89893715.filter(c)
	return c:IsSetCard(0x39) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c89893715.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c89893715.filter,tp,LOCATION_DECK,0,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,2,tp,LOCATION_DECK)
end
function c89893715.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c89893715.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:Select(tp,2,2,nil)
	Duel.SendtoGrave(sg,REASON_EFFECT)
end
