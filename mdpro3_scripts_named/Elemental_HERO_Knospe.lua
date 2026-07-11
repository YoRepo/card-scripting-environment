--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Elemental HERO Knospe  (ID: 62107981)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 3
-- ATK 600 | DEF 1000
-- Setcode: 0x3008
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each time this card inflicts Battle Damage to your opponent: It gains 100 ATK and loses 100 DEF.
-- While you control another face-up "Elemental HERO" monster, your opponent cannot target this card
-- for an attack, and this card can attack your opponent directly.
--[[ __CARD_HEADER_END__ ]]

--E・HERO クノスペ
function c62107981.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c62107981.atcon)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(62107981,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c62107981.adcon)
	e2:SetOperation(c62107981.adop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c62107981.atcon)
	e3:SetValue(aux.imval1)
	c:RegisterEffect(e3)
end
function c62107981.adcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c62107981.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:GetDefense()>=100 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(100)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetValue(-100)
		c:RegisterEffect(e2)
	end
end
function c62107981.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3008)
end
function c62107981.atcon(e)
	return Duel.IsExistingMatchingCard(c62107981.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
