--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 火山转轮  (ID: 81020140)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 3
-- ATK 1200 | DEF 600
-- Setcode: 50
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，可以让卡组的1只名字带有「火山」的怪兽在卡组最上面放置。
--[[ __CARD_HEADER_END__ ]]

--ヴォルカニック・リボルバー
function c81020140.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81020140,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c81020140.condition)
	e1:SetTarget(c81020140.target)
	e1:SetOperation(c81020140.operation)
	c:RegisterEffect(e1)
end
function c81020140.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c81020140.filter(c)
	return c:IsSetCard(0x32) and c:IsType(TYPE_MONSTER)
end
function c81020140.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81020140.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c81020140.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(81020140,1))
	local g=Duel.SelectMatchingCard(tp,c81020140.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(g:GetFirst(),SEQ_DECKTOP)
		Duel.ConfirmDecktop(tp,1)
	end
end
