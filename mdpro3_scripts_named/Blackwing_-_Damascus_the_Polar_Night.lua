--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Blackwing - Damascus the Polar Night  (ID: 58131925)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level: 3
-- ATK 1300 | DEF 700
-- Setcode: 0x33
-- Scope: OCG / TCG
--
-- Effect Text:
-- During either player's turn: You can discard this card to target 1 "Blackwing" monster you control;
-- it gains 500 ATK until the End Phase.
--[[ __CARD_HEADER_END__ ]]

--BF－極夜のダマスカス
function c58131925.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58131925,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	e1:SetCost(c58131925.cost)
	e1:SetTarget(c58131925.target)
	e1:SetOperation(c58131925.operation)
	c:RegisterEffect(e1)
end
function c58131925.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c58131925.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x33)
end
function c58131925.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c58131925.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c58131925.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c58131925.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c58131925.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
