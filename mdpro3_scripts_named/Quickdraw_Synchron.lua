--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Quickdraw Synchron  (ID: 20932152)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Machine
-- Level: 5
-- ATK 700 | DEF 1400
-- Setcode: 0x1017
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Special Summon this card (from your hand) by sending 1 monster from your hand to the GY.
-- For a Synchro Summon, you can substitute this card for any 1 "Synchron" Tuner.
-- Cannot be used as a Synchro Material, except for the Synchro Summon of a monster that mentions a
-- "Synchron" Tuner as material.
--[[ __CARD_HEADER_END__ ]]

--クイック・シンクロン
function c20932152.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c20932152.spcon)
	e1:SetTarget(c20932152.sptg)
	e1:SetOperation(c20932152.spop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c20932152.synlimit)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(20932152)
	c:RegisterEffect(e3)
end
function c20932152.synlimit(e,c)
	if not c then return false end
	return not aux.IsMaterialListSetCard(c,0x1017)
end
function c20932152.spfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c20932152.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c20932152.spfilter,tp,LOCATION_HAND,0,1,c)
end
function c20932152.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c20932152.spfilter,tp,LOCATION_HAND,0,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c20932152.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
end
