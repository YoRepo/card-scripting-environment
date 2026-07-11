--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Reptilianne Hydra  (ID: 60634565)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Reptile
-- Level: 6
-- ATK 2100 | DEF 1500
-- Setcode: 0x3c
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Reptilianne" Tuner + 1+ non-Tuner monsters
-- If this card is Synchro Summoned: Destroy as many monsters your opponent controls with 0 ATK as
-- possible, and if you do, draw 1 card for each monster destroyed.
--[[ __CARD_HEADER_END__ ]]

--レプティレス・ラミア
function c60634565.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x3c),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60634565,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c60634565.descon)
	e1:SetTarget(c60634565.destg)
	e1:SetOperation(c60634565.desop)
	c:RegisterEffect(e1)
end
function c60634565.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c60634565.desfilter(c)
	return c:IsFaceup() and c:IsAttack(0)
end
function c60634565.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c60634565.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,g:GetCount())
end
function c60634565.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c60634565.desfilter,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
