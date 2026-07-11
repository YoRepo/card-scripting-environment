--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Xiangke Magician  (ID: 71692913)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 7
-- ATK 2500 | DEF 500
-- Pendulum Scale: L3 / R3
-- Setcode: 0x98
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 3
-- [ Pendulum Effect ]
-- Once per turn: You can target 1 face-up Xyz Monster you control; this turn, you can use it as an Xyz
-- Material for an Xyz Summon using its Rank as if it were a Level (even if this card leaves the
-- field).
-- ----------------------------------------
-- [ Monster Effect ]
-- Once per turn, during either player's turn: You can target 1 LIGHT monster on the field; that
-- face-up monster has its effects negated until the end of this turn.
--[[ __CARD_HEADER_END__ ]]

--相克の魔術師
function c71692913.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--xyz level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c71692913.xyztg)
	e2:SetOperation(c71692913.xyzop)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetTarget(c71692913.distg)
	e3:SetOperation(c71692913.disop)
	c:RegisterEffect(e3)
end
function c71692913.xyzfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c71692913.xyztg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c71692913.xyzfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c71692913.xyzfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c71692913.xyzfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c71692913.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_LEVEL)
		e1:SetValue(c71692913.xyzlv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c71692913.xyzlv(e,c,rc)
	return c:GetRank()
end
function c71692913.disfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and aux.NegateEffectMonsterFilter(c)
end
function c71692913.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c71692913.disfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c71692913.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
	local g=Duel.SelectTarget(tp,c71692913.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c71692913.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
