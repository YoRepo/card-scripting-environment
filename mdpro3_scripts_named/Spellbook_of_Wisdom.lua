--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Spellbook of Wisdom  (ID: 88616795)
-- Type: Spell / Quick-Play
-- Setcode: 0x106e
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 Spellcaster monster on the field, then activate 1 of these effects;
-- ● That face-up monster is unaffected by other Spell effects this turn.
-- ● That face-up monster is unaffected by Trap effects this turn.
--[[ __CARD_HEADER_END__ ]]

--トーラの魔導書
function c88616795.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c88616795.target)
	e1:SetOperation(c88616795.activate)
	c:RegisterEffect(e1)
end
function c88616795.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
function c88616795.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c88616795.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c88616795.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c88616795.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local opt=Duel.SelectOption(tp,aux.Stringid(88616795,0),aux.Stringid(88616795,1))
	e:SetLabel(opt)
end
function c88616795.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		if e:GetLabel()==0 then
			e2:SetValue(c88616795.efilter1)
		else
			e2:SetValue(c88616795.efilter2)
		end
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
function c88616795.efilter1(e,te)
	return te:IsActiveType(TYPE_SPELL) and te:GetOwner()~=e:GetOwner()
end
function c88616795.efilter2(e,te)
	return te:IsActiveType(TYPE_TRAP)
end
