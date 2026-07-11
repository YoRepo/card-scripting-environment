--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Battlin' Boxer Sparrer  (ID: 32750341)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level: 4
-- ATK 1200 | DEF 1400
-- Setcode: 0x1084
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Battlin' Boxer" monster, you can Special Summon this card (from your hand).
-- If you do, you cannot conduct your Battle Phase for the rest of this turn.
--[[ __CARD_HEADER_END__ ]]

--BK スパー
function c32750341.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c32750341.spcon)
	e1:SetOperation(c32750341.spop)
	c:RegisterEffect(e1)
end
function c32750341.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1084)
end
function c32750341.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c32750341.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c32750341.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
