--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Counter Gem  (ID: 11136371)
-- Type: Trap
-- Setcode: 0x47
-- Scope: OCG / TCG
--
-- Effect Text:
-- Send all cards in your Spell & Trap Zone to the GY.
-- Place as many "Crystal Beast" monsters as possible from your GY face-up in your Spell & Trap Zone as
-- Continuous Spells.
-- During the End Phase of this turn, destroy all "Crystal Beast" cards you control.
--[[ __CARD_HEADER_END__ ]]

--カウンター・ジェム
function c11136371.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c11136371.plcost)
	e1:SetTarget(c11136371.pltg)
	e1:SetOperation(c11136371.plop)
	c:RegisterEffect(e1)
end
function c11136371.cfilter(c)
	return c:GetSequence()<5 and c:IsAbleToGraveAsCost()
end
function c11136371.plcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11136371.cfilter,tp,LOCATION_SZONE,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c11136371.cfilter,tp,LOCATION_SZONE,0,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c11136371.plfilter(c)
	return c:IsSetCard(0x1034) and c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c11136371.pltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11136371.plfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE)
end
function c11136371.plop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c11136371.plfilter,tp,LOCATION_GRAVE,0,ft,ft,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
			e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCondition(c11136371.descon)
	e1:SetOperation(c11136371.desop)
	Duel.RegisterEffect(e1,tp)
end
function c11136371.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1034)
end
function c11136371.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c11136371.desfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c11136371.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c11136371.desfilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
