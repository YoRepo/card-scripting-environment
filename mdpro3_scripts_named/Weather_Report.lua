--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Weather Report  (ID: 72053645)
-- Type: Monster / Effect / Flip
-- Attribute: WATER
-- Race: Aqua
-- Level: 4
-- ATK 950 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Destroys all opponent's face-up "Swords of Revealing Light" on the field.
-- If "Swords of Revealing Light" is destroyed, you can perform your Battle Phase twice this turn (or
-- your next turn, if activated during opponent's turn).
--[[ __CARD_HEADER_END__ ]]

--ウェザー・レポート
function c72053645.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(72053645,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c72053645.target)
	e1:SetOperation(c72053645.operation)
	c:RegisterEffect(e1)
end
function c72053645.filter(c)
	return c:IsFaceup() and c:IsCode(72302403)
end
function c72053645.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c72053645.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c72053645.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c72053645.filter,tp,0,LOCATION_ONFIELD,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_BP_TWICE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		if Duel.GetTurnPlayer()==tp and (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) then
			e1:SetLabel(Duel.GetTurnCount())
			e1:SetCondition(c72053645.bpcon)
			e1:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_SELF_TURN,2)
		else
			e1:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_SELF_TURN,1)
		end
		Duel.RegisterEffect(e1,tp)
	end
end
function c72053645.bpcon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end
