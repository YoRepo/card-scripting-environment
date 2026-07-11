--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Darton the Mechanical Monstrosity  (ID: 86271510)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 1
-- ATK ? | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during your Main Phase: You can check the difference between the current and original
-- ATK of each monster on the field, add up the total of each of those differences, and make this
-- monster's original ATK become that combined amount until the end of your opponent's next turn.
--[[ __CARD_HEADER_END__ ]]

--機怪獣ダレトン
function c86271510.initial_effect(c)
	--atk change
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c86271510.target)
	e1:SetOperation(c86271510.operation)
	c:RegisterEffect(e1)
end
function c86271510.filter(c)
	return c:IsFaceup() and not c:IsAttack(c:GetBaseAttack())
end
function c86271510.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c86271510.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c86271510.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	local atk=0
	while tc do
		local batk=tc:GetBaseAttack()
		local catk=tc:GetAttack()
		atk=math.abs(catk-batk)+atk
		tc=g:GetNext()
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK_FINAL)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	c:RegisterEffect(e1)
end
