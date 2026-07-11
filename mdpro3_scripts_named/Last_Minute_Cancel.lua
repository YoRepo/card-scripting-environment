--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Last Minute Cancel  (ID: 95254840)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares an attack while you control an Attack Position monster(s):
-- Change all monsters you control to Defense Position.
-- For the rest of this turn after this card resolves, return any face-up "Performapal" monster you
-- control that is destroyed by battle or card effect to the hand instead of sending it to the
-- Graveyard.
--[[ __CARD_HEADER_END__ ]]

--ドタキャン
function c95254840.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c95254840.condition)
	e1:SetTarget(c95254840.target)
	e1:SetOperation(c95254840.activate)
	c:RegisterEffect(e1)
end
function c95254840.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c95254840.filter(c)
	return c:IsAttackPos() and c:IsCanChangePosition()
end
function c95254840.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c95254840.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c95254840.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c95254840.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(c95254840.rmtg)
		e1:SetValue(LOCATION_HAND)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c95254840.rmtg(e,c)
	return c:IsSetCard(0x9f) and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
