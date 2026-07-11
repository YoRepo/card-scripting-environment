--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Groza, Tyrant of Thunder  (ID: 45420955)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Fiend
-- Level: 8
-- ATK 2800 | DEF 2800
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner Fiend monsters
-- During your opponent's Main Phase (Quick Effect): You can target 1 Effect Monster on the field;
-- discard 1 monster, and if you do, negate that monster's effect until the end of this turn.
-- You can only use this effect of "Groza, Tyrant of Thunder" once per turn.
-- If a Fiend monster(s) is sent from the hand to your GY (except during the Damage Step): You can
-- apply 1 of the following effects to this card, until the end of this turn.
-- ● Cannot be destroyed by battle.
-- ● Cannot be destroyed by your opponent's card effects.
-- ● Your opponent cannot target this card with card effects.
--[[ __CARD_HEADER_END__ ]]

--迅雷の暴君 グローザー
function c45420955.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_FIEND),1)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45420955,0))
	e1:SetCategory(CATEGORY_HANDES_SELF+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCountLimit(1,45420955)
	e1:SetCondition(c45420955.negcon)
	e1:SetTarget(c45420955.negtg)
	e1:SetOperation(c45420955.negop)
	c:RegisterEffect(e1)
	--protection
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(45420955,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c45420955.econ)
	e2:SetOperation(c45420955.eop)
	c:RegisterEffect(e2)
end
function c45420955.dcfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c45420955.negcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c45420955.negtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and aux.NegateEffectMonsterFilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(aux.NegateEffectMonsterFilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) and Duel.IsExistingMatchingCard(c45420955.dcfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
	local g=Duel.SelectTarget(tp,aux.NegateEffectMonsterFilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c45420955.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,c45420955.dcfilter,1,1,REASON_EFFECT+REASON_DISCARD)>0 then
		local c=e:GetHandler()
		local tc=Duel.GetFirstTarget()
		if ((tc:IsFaceup() and tc:IsType(TYPE_MONSTER) and not tc:IsDisabled()) or tc:IsType(TYPE_TRAPMONSTER)) and tc:IsRelateToEffect(e) then
			Duel.NegateRelatedChain(tc,RESET_TURN_SET)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetValue(RESET_TURN_SET)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
			if tc:IsType(TYPE_TRAPMONSTER) then
				local e3=Effect.CreateEffect(c)
				e3:SetType(EFFECT_TYPE_SINGLE)
				e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
				e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
				tc:RegisterEffect(e3)
			end
		end
	end
end
function c45420955.cfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_FIEND) and c:IsPreviousLocation(LOCATION_HAND) and c:IsControler(tp)
end
function c45420955.econ(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return eg:IsExists(c45420955.cfilter,1,nil,tp)
		and (c:GetFlagEffect(45420955)==0 or bit.band(c:GetFlagEffectLabel(45420955),0x7)~=0x7 or not c:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) or not c:IsHasEffect(EFFECT_INDESTRUCTABLE_EFFECT)
			or not c:IsHasEffect(EFFECT_CANNOT_BE_EFFECT_TARGET))
end
function c45420955.eop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local b1=(c:GetFlagEffect(45420955)==0 or bit.band(c:GetFlagEffectLabel(45420955),0x1)==0 or not c:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE))
	local b2=(c:GetFlagEffect(45420955)==0 or bit.band(c:GetFlagEffectLabel(45420955),0x2)==0 or not c:IsHasEffect(EFFECT_INDESTRUCTABLE_EFFECT))
	local b3=(c:GetFlagEffect(45420955)==0 or bit.band(c:GetFlagEffectLabel(45420955),0x4)==0 or not c:IsHasEffect(EFFECT_CANNOT_BE_EFFECT_TARGET))
	if not b1 and not b2 and not b3 then return end
	local off=1
	local ops={}
	local opval={}
	if b1 then
		ops[off]=aux.Stringid(45420955,2)
		opval[off]=0
		off=off+1
	end
	if b2 then
		ops[off]=aux.Stringid(45420955,3)
		opval[off]=1
		off=off+1
	end
	if b3 then
		ops[off]=aux.Stringid(45420955,4)
		opval[off]=2
		off=off+1
	end
	local op=Duel.SelectOption(tp,table.unpack(ops))+1
	local sel=opval[op]
	if sel==0 then
		if c:GetFlagEffect(45420955)==0 then
			c:RegisterFlagEffect(45420955,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
		end
		c:SetFlagEffectLabel(45420955,bit.bor(c:GetFlagEffectLabel(45420955),0x1))
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(45420955,2))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		c:RegisterEffect(e1)
	elseif sel==1 then
		if c:GetFlagEffect(45420955)==0 then
			c:RegisterFlagEffect(45420955,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
		end
		c:SetFlagEffectLabel(45420955,bit.bor(c:GetFlagEffectLabel(45420955),0x2))
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(45420955,3))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetValue(aux.indoval)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	else
		if c:GetFlagEffect(45420955)==0 then
			c:RegisterFlagEffect(45420955,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
		end
		c:SetFlagEffectLabel(45420955,bit.bor(c:GetFlagEffectLabel(45420955),0x4))
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(45420955,4))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e1:SetValue(aux.tgoval)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
