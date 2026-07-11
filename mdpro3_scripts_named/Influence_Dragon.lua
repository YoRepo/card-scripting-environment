--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Influence Dragon  (ID: 54936498)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Dragon
-- Level: 3
-- ATK 300 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can target 1 face-up monster you control; it becomes Dragon-Type until the End
-- Phase.
--[[ __CARD_HEADER_END__ ]]

--インフルーエンス・ドラゴン
function c54936498.initial_effect(c)
	--lv up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54936498,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c54936498.tg)
	e1:SetOperation(c54936498.op)
	c:RegisterEffect(e1)
end
function c54936498.filter(c)
	return c:IsFaceup() and not c:IsRace(RACE_DRAGON)
end
function c54936498.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c54936498.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c54936498.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c54936498.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c54936498.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetValue(RACE_DRAGON)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
