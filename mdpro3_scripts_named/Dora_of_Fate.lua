--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Dora of Fate  (ID: 67464807)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can only activate this card during your opponent's turn.
-- Select 1 face-up monster on your opponent's side of the field.
-- When you Normal Summon a monster that is 1 Level lower than the selected monster during your next
-- turn, inflict damage to your opponent's Life Points equal to the Level of the selected monster x 500
-- points.
--[[ __CARD_HEADER_END__ ]]

--運命のドラ
function c67464807.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_ATTACK,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCondition(c67464807.condition)
	e1:SetTarget(c67464807.target)
	e1:SetOperation(c67464807.activate)
	c:RegisterEffect(e1)
end
function c67464807.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c67464807.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(2)
end
function c67464807.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c67464807.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c67464807.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c67464807.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c67464807.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local lv=tc:GetLevel()
		if lv>1 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_SUMMON_SUCCESS)
			e1:SetCountLimit(1)
			e1:SetCondition(c67464807.damcon)
			e1:SetOperation(c67464807.damop)
			e1:SetLabel(lv)
			e1:SetReset(RESET_PHASE+PHASE_END,2)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c67464807.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and ep==tp and eg:GetFirst():IsLevel(e:GetLabel()-1)
end
function c67464807.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,e:GetLabel()*500,REASON_EFFECT)
end
