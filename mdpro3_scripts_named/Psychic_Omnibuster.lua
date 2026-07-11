--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: test-update.cdb
-- Card: Psychic Omnibuster  (ID: 70659412)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Psychic
-- Level: 7
-- ATK 2500 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner Psychic monsters
-- Each time your opponent activates a card or effect on the field (except during the Damage Step): You
-- can pay 2000 LP and declare 1 card type (Monster, Spell, or Trap) (but you can only declare each
-- card type once per turn to activate this effect of "Psychic Omnibuster"); look at 1 random card in
-- your opponent's hand, and if it is the declared card type, apply these effects in sequence (skip
-- over any that do not apply).
-- ● This card cannot be destroyed by the effects of the declared card type this turn.
-- ● Banish the card you looked at, face-up, until the End Phase.
--[[ __CARD_HEADER_END__ ]]

--Psychic Omnibuster
local s,id,o=GetID()
function s.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_PSYCHO),1)
	c:EnableReviveLimit()
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.rmcon)
	e1:SetCost(s.rmcost)
	e1:SetTarget(s.rmtg)
	e1:SetOperation(s.rmop)
	c:RegisterEffect(e1)
end
function s.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return bit.band(loc,LOCATION_ONFIELD)~=0 and rp==1-tp
		and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
end
function s.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
end
function s.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.GetFlagEffect(tp,id)==0
	local b2=Duel.GetFlagEffect(tp,id+o)==0
	local b3=Duel.GetFlagEffect(tp,id+o*2)==0
	if chk==0 then return (b1 or b2 or b3) and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)~=0 end
	local op=0
	if b1 or b2 or b3 then
		op=aux.SelectFromOptions(tp,
			{b1,1050,TYPE_MONSTER},
			{b2,1051,TYPE_SPELL},
			{b3,1052,TYPE_TRAP})
	end
	e:SetLabel(op)
	if op==TYPE_MONSTER then
		Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
	elseif op==TYPE_SPELL then
		Duel.RegisterFlagEffect(tp,id+o,RESET_PHASE+PHASE_END,0,1)
	elseif op==TYPE_TRAP then
		Duel.RegisterFlagEffect(tp,id+o*2,RESET_PHASE+PHASE_END,0,1)
	end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,1-tp,LOCATION_HAND)
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(ep,1)
	Duel.ConfirmCards(tp,sg)
	if sg:GetFirst():IsType(e:GetLabel()) then
		if c:IsRelateToChain() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(e:GetLabel())
			e1:SetValue(s.efilter)
			c:RegisterEffect(e1)
			Duel.BreakEffect()
		end
		if Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)~=0 then
			local tc=sg:GetFirst()
			local fid=c:GetFieldID()
			tc:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1,fid)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetCountLimit(1)
			e1:SetLabel(fid)
			e1:SetReset(RESET_PHASE+PHASE_END)
			e1:SetLabelObject(tc)
			e1:SetCondition(s.retcon)
			e1:SetOperation(s.retop)
			Duel.RegisterEffect(e1,tp)
		end
	end
	Duel.ShuffleHand(1-tp)
end
function s.efilter(e,re)
	return re:GetOwner():IsType(e:GetLabel())
end
function s.retcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(id)==e:GetLabel() then
		return true
	else
		e:Reset()
		return false
	end
end
function s.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.SendtoHand(tc,1-tp,REASON_EFFECT)
end
