--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Vaylantz Dominator Duke  (ID: 13291886)
-- Type: Monster / Effect / Pendulum
-- Attribute: FIRE
-- Race: Machine
-- Level: 8
-- ATK 2000 | DEF 2000
-- Pendulum Scale: L1 / R1
-- Setcode: 0x17d
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 1
-- [ Pendulum Effect ]
-- If "Vaylantz World - Konig Wissen" is in a Field Zone or if you control a FIRE "Vaylantz" monster:
-- You can Special Summon this card to your Main Monster Zone in its same column.
-- You can only use this effect of "Vaylantz Dominator Duke" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- You can target 1 Set card in the Spell & Trap Zone; that Set card cannot be activated this turn
-- (even if this card leaves the field).
-- If this card in the Monster Zone moves to another Monster Zone: You can target 1 face-up monster in
-- your opponent's Main Monster Zone; take control of that face-up monster, but it cannot declare an
-- attack nor activate its effects, also it is treated as a "Vaylantz" monster.
-- You can only use each effect of "Vaylantz Dominator Duke" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ヴァリアンツD－デューク
function c13291886.initial_effect(c)
	aux.AddCodeList(c,75952542)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,13291886)
	e1:SetCondition(c13291886.spcon)
	e1:SetTarget(c13291886.sptg)
	e1:SetOperation(c13291886.spop)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,13291887)
	e2:SetTarget(c13291886.altg)
	e2:SetOperation(c13291886.alop)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_CONTROL)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_MOVE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,13291888)
	e3:SetCondition(c13291886.mvcon)
	e3:SetTarget(c13291886.mvtg)
	e3:SetOperation(c13291886.mvop)
	c:RegisterEffect(e3)
end
function c13291886.cfilter(c)
	return c:IsSetCard(0x17d) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsFaceup()
end
function c13291886.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(75952542) or Duel.IsExistingMatchingCard(c13291886.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c13291886.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local zone=1<<c:GetSequence()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c13291886.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local zone=1<<c:GetSequence()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
function c13291886.alfilter(c)
	return c:IsFacedown() and c:GetSequence()<5
end
function c13291886.altg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c13291886.alfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13291886.alfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(13291886,0))
	Duel.SelectTarget(tp,c13291886.alfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
end
function c13291886.alop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c13291886.mvcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsLocation(LOCATION_MZONE)
		and (c:GetPreviousSequence()~=c:GetSequence() or c:GetPreviousControler()~=tp)
end
function c13291886.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged() and c:GetSequence()<=4
end
function c13291886.mvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c13291886.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13291886.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c13291886.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c13291886.mvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and Duel.GetControl(tc,tp)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_TRIGGER)
		tc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_ADD_SETCODE)
		e3:SetValue(0x17d)
		tc:RegisterEffect(e3)
	end
end
