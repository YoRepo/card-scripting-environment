--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Force Resonator  (ID: 40583194)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Fiend
-- Level: 2
-- ATK 500 | DEF 500
-- Setcode: 0x57
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can send this face-up card you control to the GY, then target 1 face-up monster you control; if
-- it attacks this turn, your opponent cannot activate cards or effects that target a monster(s) until
-- the end of the Damage Step.
--[[ __CARD_HEADER_END__ ]]

--フォース・リゾネーター
function c40583194.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40583194,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c40583194.cost)
	e1:SetTarget(c40583194.target)
	e1:SetOperation(c40583194.operation)
	c:RegisterEffect(e1)
end
function c40583194.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c40583194.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c40583194.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SELECT_EFFECT_TARGET)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(0,0xff)
		e1:SetValue(c40583194.etarget)
		e1:SetCondition(c40583194.limcon)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c40583194.etarget(e,re,c)
	return c:IsType(TYPE_MONSTER) and (c:IsFaceup() or c:IsLocation(LOCATION_MZONE))
end
function c40583194.limcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
