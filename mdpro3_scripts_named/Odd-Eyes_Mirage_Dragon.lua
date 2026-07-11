--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Odd-Eyes Mirage Dragon  (ID: 67754901)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Dragon
-- Level: 3
-- ATK 1200 | DEF 600
-- Pendulum Scale: L8 / R8
-- Setcode: 0x99
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 8
-- [ Pendulum Effect ]
-- Once per turn, if a face-up "Odd-Eyes" Pendulum Monster(s) you control is destroyed by battle or
-- card effect: You can destroy 1 card in your Pendulum Zone, and if you do, place 1 face-up "Odd-Eyes"
-- Pendulum Monster in your Extra Deck in your Pendulum Zone, except "Odd-Eyes Mirage Dragon".
-- ----------------------------------------
-- [ Monster Effect ]
-- While an "Odd-Eyes" card is in your Pendulum Zone (Quick Effect): You can target 1 "Odd-Eyes"
-- monster you control; the first time it would be destroyed by battle or card effect this turn, it is
-- not destroyed.
-- You can only use this effect of "Odd-Eyes Mirage Dragon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--オッドアイズ・ミラージュ・ドラゴン
function c67754901.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67754901,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,67754901)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c67754901.indcon)
	e1:SetTarget(c67754901.indtg)
	e1:SetOperation(c67754901.indop)
	c:RegisterEffect(e1)
	--pendulum set
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c67754901.pencon)
	e2:SetTarget(c67754901.pentg)
	e2:SetOperation(c67754901.penop)
	c:RegisterEffect(e2)
end
function c67754901.indfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x99)
end
function c67754901.indcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,1,nil,0x99)
end
function c67754901.indtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c67754901.indfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c67754901.indfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c67754901.indfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c67754901.indop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCountLimit(1)
		e1:SetValue(c67754901.valcon)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c67754901.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c67754901.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsSetCard(0x99) and c:IsType(TYPE_PENDULUM)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp)
end
function c67754901.penfilter(c)
	return c:IsSetCard(0x99) and c:IsType(TYPE_PENDULUM) and c:IsFaceup() and not c:IsCode(67754901) and not c:IsForbidden()
end
function c67754901.pencon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c67754901.cfilter,1,nil,tp)
end
function c67754901.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_PZONE,0)>0
		and Duel.IsExistingMatchingCard(c67754901.penfilter,tp,LOCATION_EXTRA,0,1,nil) end
	local g=Duel.GetFieldGroup(tp,LOCATION_PZONE,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c67754901.penop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.GetFieldGroup(tp,LOCATION_PZONE,0):Select(tp,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		if Duel.Destroy(g,REASON_EFFECT)==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local sg=Duel.SelectMatchingCard(tp,c67754901.penfilter,tp,LOCATION_EXTRA,0,1,1,nil)
		local tc=sg:GetFirst()
		if tc then
			Duel.MoveToField(tc,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
		end
	end
end
