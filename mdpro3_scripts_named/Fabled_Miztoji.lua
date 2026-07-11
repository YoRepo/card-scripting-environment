--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Fabled Miztoji  (ID: 8316661)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Fiend
-- Level: 2
-- ATK 400 | DEF 200
-- Setcode: 0x35
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can send this card from your hand to the GY, then target 1 non-Tuner "Fabled" monster you
-- control; that monster is treated as a Tuner while face-up on the field.
--[[ __CARD_HEADER_END__ ]]

--魔轟神ミーズトージ
function c8316661.initial_effect(c)
	--change type
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8316661,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c8316661.cost)
	e1:SetTarget(c8316661.tg)
	e1:SetOperation(c8316661.op)
	c:RegisterEffect(e1)
end
function c8316661.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c8316661.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x35) and not c:IsType(TYPE_TUNER)
end
function c8316661.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c8316661.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c8316661.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c8316661.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c8316661.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetValue(TYPE_TUNER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
