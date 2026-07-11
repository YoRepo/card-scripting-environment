--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Ally of Justice Searcher  (ID: 3648368)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 3
-- ATK 1400 | DEF 100
-- Setcode: 0x1
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can discard 1 card, then target 1 face-down Defense Position monster your
-- opponent controls; change that target to face-up Attack Position.
-- (Flip monsters' effects are not activated.)
--[[ __CARD_HEADER_END__ ]]

--A・O・J リサーチャー
function c3648368.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3648368,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c3648368.cost)
	e1:SetTarget(c3648368.target)
	e1:SetOperation(c3648368.operation)
	c:RegisterEffect(e1)
end
function c3648368.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c3648368.filter(c)
	return c:IsFacedown() and c:IsDefensePos()
end
function c3648368.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c3648368.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c3648368.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWNDEFENSE)
	local g=Duel.SelectTarget(tp,c3648368.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c3648368.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and c3648368.filter(tc) then
		Duel.ChangePosition(tc,0,0,0,POS_FACEUP_ATTACK,true)
	end
end
