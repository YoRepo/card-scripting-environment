--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Delta Flyer  (ID: 57568840)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Dragon
-- Level: 3
-- ATK 1500 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can target 1 other face-up monster you control; increase the target's Level by 1.
--[[ __CARD_HEADER_END__ ]]

--デルタフライ
function c57568840.initial_effect(c)
	--lvchange
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57568840,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c57568840.lvtg)
	e1:SetOperation(c57568840.lvop)
	c:RegisterEffect(e1)
end
function c57568840.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(0)
end
function c57568840.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c57568840.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c57568840.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c57568840.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c57568840.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
