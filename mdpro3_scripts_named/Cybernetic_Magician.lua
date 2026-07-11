--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Cybernetic Magician  (ID: 59023523)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 6
-- ATK 2400 | DEF 1000
-- Setcode: 0x94
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can discard 1 card to target 1 face-up monster on the field; that target's ATK becomes 2000
-- until the End Phase.
--[[ __CARD_HEADER_END__ ]]

--サイバネティック・マジシャン
function c59023523.initial_effect(c)
	--atk change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(59023523,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c59023523.cost)
	e1:SetTarget(c59023523.target)
	e1:SetOperation(c59023523.operation)
	c:RegisterEffect(e1)
end
function c59023523.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c59023523.filter(c)
	return c:IsFaceup() and not c:IsAttack(2000)
end
function c59023523.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c59023523.filter(chkc) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(c59023523.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c59023523.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c59023523.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(2000)
		tc:RegisterEffect(e1)
	end
end
