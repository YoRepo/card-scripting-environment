--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Shootingcode Talker  (ID: 33897356)
-- Type: Monster / Effect / Link
-- Attribute: WATER
-- Race: Cyberse
-- Link Rating: 3
-- Link Arrows: Top, Left, Bottom
-- ATK 2300
-- Setcode: 0x101
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2+ Cyberse monsters
-- At the start of your Battle Phase: You can activate this effect; this Battle Phase, this card can
-- make attacks on your opponent's monsters, up to the number of monsters this card currently points to
-- +1, but this turn, when it attacks your opponent's only monster, this card loses 400 ATK during that
-- damage calculation only.
-- At the end of each Battle Phase: You can draw cards equal to the number of monsters this card
-- destroyed by battle this turn.
--[[ __CARD_HEADER_END__ ]]

--シューティングコード・トーカー
function c33897356.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33897356,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c33897356.condition)
	e1:SetTarget(c33897356.target)
	e1:SetOperation(c33897356.operation)
	c:RegisterEffect(e1)
	--destroy reg
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetOperation(c33897356.regop)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c33897356.drtg)
	e3:SetOperation(c33897356.drop)
	c:RegisterEffect(e3)
end
function c33897356.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c33897356.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetLinkedGroupCount()>0 end
end
function c33897356.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e1:SetValue(e:GetHandler():GetLinkedGroupCount())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCondition(c33897356.atkcon)
		e2:SetValue(-400)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
	end
end
function c33897356.atkcon(e)
	if not Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL then return false end
	local tp=e:GetHandlerPlayer()
	local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	if #g~=1 then return false end
	local c=e:GetHandler()
	local bc=g:GetFirst()
	return (c==Duel.GetAttacker() and bc==Duel.GetAttackTarget()) or (bc==Duel.GetAttacker() and c==Duel.GetAttackTarget())
end
function c33897356.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToBattle() then return end
	local ct=c:GetFlagEffectLabel(33897356)
	if ct then
		c:SetFlagEffectLabel(33897356,ct+1)
	else
		c:RegisterFlagEffect(33897356,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1,1)
	end
end
function c33897356.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetHandler():GetFlagEffectLabel(33897356)
	if chk==0 then return ct and Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c33897356.drop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetFlagEffectLabel(33897356)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
