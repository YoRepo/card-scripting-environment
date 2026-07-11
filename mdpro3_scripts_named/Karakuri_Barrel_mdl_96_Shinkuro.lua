--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Karakuri Barrel mdl 96 "Shinkuro"  (ID: 92300891)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Machine
-- Level: 2
-- ATK 400 | DEF 400
-- Setcode: 0x11, 0x17
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card must attack if able.
-- When this face-up Attack Position card is selected as an attack target, change it to Defense
-- Position.
-- Once per turn, this card cannot be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--カラクリ樽 真九六
function c92300891.initial_effect(c)
	--must attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MUST_ATTACK)
	c:RegisterEffect(e1)
	--to defense
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(92300891,0))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetCondition(c92300891.poscon)
	e3:SetOperation(c92300891.posop)
	c:RegisterEffect(e3)
	--battle indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e4:SetCountLimit(1)
	e4:SetValue(c92300891.valcon)
	c:RegisterEffect(e4)
end
function c92300891.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c92300891.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
function c92300891.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
