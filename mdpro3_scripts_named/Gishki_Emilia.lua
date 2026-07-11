--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Gishki Emilia  (ID: 73551138)
-- Type: Monster / Effect / Spirit
-- Attribute: WATER
-- Race: Spellcaster
-- Level: 4
-- ATK 1600 | DEF 800
-- Setcode: 0x3a
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- During the End Phase of the turn this card is Normal Summoned or flipped face-up: Return it to the
-- hand.
-- When this card is Normal Summoned or flipped face-up: Negate all Trap Card effects on the field,
-- until the End Phase.
-- You must control another face-up "Gishki" monster to activate and to resolve this effect.
--[[ __CARD_HEADER_END__ ]]

--リチュア・エミリア
function c73551138.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--negate trap
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(73551138,1))
	e4:SetCategory(CATEGORY_DISABLE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetCondition(c73551138.negcon)
	e4:SetOperation(c73551138.negop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_FLIP)
	c:RegisterEffect(e5)
end
function c73551138.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3a)
end
function c73551138.negcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c73551138.filter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c73551138.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsExistingMatchingCard(c73551138.filter,tp,LOCATION_MZONE,0,1,c) then return end
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c73551138.distg)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	--disable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetOperation(c73551138.disop)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	--disable trap monster
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c73551138.distg)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c73551138.distg(e,c)
	return c~=e:GetHandler() and c:IsType(TYPE_TRAP)
end
function c73551138.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_TRAP) then
		Duel.NegateEffect(ev)
	end
end
