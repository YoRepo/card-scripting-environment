--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Marincess Sea Star  (ID: 62886670)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Cyberse
-- Level: 2
-- ATK 800 | DEF 400
-- Setcode: 0x12b
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can send this card from your hand to the GY, then target 1 "Marincess" monster you control; it
-- gains 800 ATK until the end of this turn.
-- You can use this effect of "Marincess Sea Star" up to twice per turn.
--[[ __CARD_HEADER_END__ ]]

--海晶乙女シースター
function c62886670.initial_effect(c)
	--boost
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62886670,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(2,62886670)
	e1:SetCost(c62886670.adcost)
	e1:SetTarget(c62886670.adtg)
	e1:SetOperation(c62886670.adop)
	c:RegisterEffect(e1)
end
function c62886670.adcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c62886670.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x12b)
end
function c62886670.adtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c62886670.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c62886670.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c62886670.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c62886670.adop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(800)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
