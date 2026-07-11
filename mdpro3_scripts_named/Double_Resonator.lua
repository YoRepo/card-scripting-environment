--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Double Resonator  (ID: 60832978)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Fiend
-- Level: 1
-- ATK 0 | DEF 0
-- Setcode: 0x57
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Normal or Special Summoned: You can target 1 face-up monster on the field; that
-- target is treated as a Tuner this turn.
-- You can banish this card from your GY, then target 1 Fiend monster you control; that Fiend monster
-- is treated as a Tuner this turn.
-- You can only use this effect of "Double Resonator" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ダブル・リゾネーター
function c60832978.initial_effect(c)
	--tuner (summon)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetTarget(c60832978.target1)
	e1:SetOperation(c60832978.operation1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--tuner (banish)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,60832978)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c60832978.target2)
	e3:SetOperation(c60832978.operation2)
	c:RegisterEffect(e3)
end
function c60832978.filter1(c)
	return c:IsFaceup() and not c:IsType(TYPE_TUNER)
end
function c60832978.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c60832978.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60832978.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c60832978.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c60832978.operation1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(TYPE_TUNER)
		tc:RegisterEffect(e1)
	end
end
function c60832978.filter2(c)
	return c60832978.filter1(c) and c:IsRace(RACE_FIEND)
end
function c60832978.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c60832978.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60832978.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c60832978.filter2,tp,LOCATION_MZONE,0,1,1,nil)
end
function c60832978.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRace(RACE_FIEND) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(TYPE_TUNER)
		tc:RegisterEffect(e1)
	end
end
