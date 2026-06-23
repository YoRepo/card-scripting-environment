--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T00:00:00
-- Card: Crimsonheart Thorns  (ID: 211060)
-- Type: Trap / Normal
-- Setcode: 0x95c (Crimsonheart)
--
-- Effect Text:
-- You can only use 1 effect of "Crimsonheart Thorns" per turn and only once that turn.
-- (1) Target 1 monster on the field or in the GY; banish it until the end of the turn.
-- (2) If this card is in your GY: You can banish this card; Set 1 "Crimsonheart" Spell/Trap directly
-- from your Deck, except "Crimsonheart Thorns".
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Thorns
local s,id,o=GetID()
function s.initial_effect(c)
	--(1) target 1 monster on field/GY; banish it until the end of the turn
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,id)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(s.rmtg)
	e1:SetOperation(s.rmop)
	c:RegisterEffect(e1)
	--(2) from GY: banish this card; Set 1 "Crimsonheart" S/T directly from Deck (except this card)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.settg)
	e2:SetOperation(s.setop)
	c:RegisterEffect(e2)
end
--(1)
function s.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and chkc:IsType(TYPE_MONSTER) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(s.rmfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,s.rmfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function s.rmfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	--remember whether it was banished from the GY: ReturnToField only restores
	--cards whose previous location was the field, so GY monsters need SendtoGrave
	local fromgrave=tc:IsLocation(LOCATION_GRAVE)
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		tc:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetLabel(fromgrave and 1 or 0)
		e1:SetLabelObject(tc)
		e1:SetCountLimit(1)
		e1:SetCondition(s.retcon)
		e1:SetOperation(s.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function s.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetFlagEffect(id)~=0
end
function s.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if e:GetLabel()==1 then
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_RETURN)
	else
		Duel.ReturnToField(tc)
	end
end
--(2)
function s.stfilter(c)
	return c:IsSetCard(0x95c) and c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsCode(id) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(s.stfilter,tp,LOCATION_DECK,0,1,nil) end
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,s.stfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SSet(tp,g)
	end
end
