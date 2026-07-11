--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Element Soldier  (ID: 66712593)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 1500 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- This monster gets the following effect(s) while there is a monster(s) with the following
-- Attribute(s) on the field:
-- ● WATER: Control of this card cannot switch.
-- ● EARTH: Negate the effect of an Effect Monster that this card destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--エレメント・ソルジャー
function c66712593.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	e1:SetCondition(c66712593.ctlcon)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c66712593.discon)
	e2:SetOperation(c66712593.disop)
	c:RegisterEffect(e2)
end
function c66712593.filter(c,att)
	return c:IsFaceup() and c:IsAttribute(att)
end
function c66712593.ctlcon(e)
	return Duel.IsExistingMatchingCard(c66712593.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_WATER)
end
function c66712593.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
		and Duel.IsExistingMatchingCard(c66712593.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_EARTH)
end
function c66712593.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x17a0000)
	bc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_EVENT+0x17a0000)
	bc:RegisterEffect(e2)
end
