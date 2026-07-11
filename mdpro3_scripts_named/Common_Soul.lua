--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Common Soul  (ID: 14772491)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Select 1 face-up monster on the field to activate this card.
-- Special Summon 1 "Neo-Spacian" monster from your hand to the same side of the field as the selected
-- monster.
-- The selected monster gains ATK equal to the ATK of the monster that was Special Summoned by this
-- effect.
-- When this card is removed from the field, return the monster that was Special Summoned by this
-- card's effect to the hand.
--[[ __CARD_HEADER_END__ ]]

--魂の共有－コモンソウル
function c14772491.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c14772491.target)
	e1:SetOperation(c14772491.operation)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c14772491.thcon)
	e2:SetOperation(c14772491.thop)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c14772491.spfilter(c,e,tp,cp)
	return c:IsSetCard(0x1f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,cp)
end
function c14772491.filter(c,e,tp)
	return c:IsFaceup() and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c14772491.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,c:GetControler())
end
function c14772491.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c14772491.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c14772491.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c14772491.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c14772491.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local cp=tc:GetControler()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		if Duel.GetLocationCount(cp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c14772491.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,cp)
		if g:GetCount()==0 then return end
		local sc=g:GetFirst()
		Duel.SpecialSummon(sc,0,tp,cp,false,false,POS_FACEUP)
		c:SetCardTarget(tc)
		c:SetCardTarget(sc)
		e:GetLabelObject():SetLabelObject(sc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetCondition(c14772491.rcon)
		e1:SetValue(sc:GetAttack())
		e1:SetLabelObject(sc)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1,true)
	end
end
function c14772491.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
		and e:GetOwner():IsHasCardTarget(e:GetLabelObject())
end
function c14772491.thcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc and tc:IsOnField() and tc:IsFaceup() and tc:IsSetCard(0x1f)
		and e:GetHandler():IsHasCardTarget(tc)
end
function c14772491.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoHand(e:GetLabelObject(),nil,REASON_EFFECT)
end
