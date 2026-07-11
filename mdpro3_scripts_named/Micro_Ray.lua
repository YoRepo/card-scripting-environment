--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Micro Ray  (ID: 18190572)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 face-up monster on the field; that target's DEF becomes 0 until the end of this turn.
--[[ __CARD_HEADER_END__ ]]

--ミクロ光線
function c18190572.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c18190572.target)
	e1:SetOperation(c18190572.activate)
	c:RegisterEffect(e1)
end
function c18190572.filter(c)
	return c:IsFaceup() and c:IsDefenseAbove(0)
end
function c18190572.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c18190572.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c18190572.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c18190572.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c18190572.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(0)
		tc:RegisterEffect(e1)
	end
end
