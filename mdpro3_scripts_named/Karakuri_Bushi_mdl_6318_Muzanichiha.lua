--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Karakuri Bushi mdl 6318 "Muzanichiha"  (ID: 39118197)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 1800 | DEF 600
-- Setcode: 0x11
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card must attack if able.
-- When this face-up Attack Position card is selected as an attack target, change it to Defense
-- Position.
-- If another "Karakuri" monster on the field is destroyed, this card gains 400 ATK.
--[[ __CARD_HEADER_END__ ]]

--カラクリ武者 六参壱八
function c39118197.initial_effect(c)
	--must attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MUST_ATTACK)
	c:RegisterEffect(e1)
	--to defense
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(39118197,0))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetCondition(c39118197.poscon)
	e3:SetOperation(c39118197.posop)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(39118197,1))
	e4:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c39118197.atkcon)
	e4:SetOperation(c39118197.atkop)
	c:RegisterEffect(e4)
end
function c39118197.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c39118197.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
function c39118197.filter(c)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousSetCard(0x11)
end
function c39118197.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c39118197.filter,1,nil)
end
function c39118197.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e1:SetValue(400)
		c:RegisterEffect(e1)
	end
end
