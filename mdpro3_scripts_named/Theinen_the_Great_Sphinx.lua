--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Theinen the Great Sphinx  (ID: 87997872)
-- Type: Monster / Effect / Special Summon
-- Attribute: LIGHT
-- Race: Beast
-- Level: 10
-- ATK 3500 | DEF 3000
-- Setcode: 0x5c
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card cannot be Normal Summoned or Set.
-- This card cannot be Special Summoned except by paying 500 Life Points when both "Andro Sphinx" and
-- "Sphinx Teleia" on your side of the field are destroyed at the same time; then you can Special
-- Summon this monster from your hand or Deck.
-- When this card is Special Summoned successfully, pay 500 Life Points to increase the ATK of this
-- card by 3000 points until the end of the End Phase.
--[[ __CARD_HEADER_END__ ]]

--スフィンクス・アンドロジュネス
function c87997872.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(87997872,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_HAND+LOCATION_DECK)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c87997872.spcon)
	e2:SetCost(c87997872.cost)
	e2:SetTarget(c87997872.sptg)
	e2:SetOperation(c87997872.spop)
	c:RegisterEffect(e2)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(87997872,1))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCost(c87997872.cost)
	e4:SetOperation(c87997872.atkop)
	c:RegisterEffect(e4)
end
function c87997872.cfilter(c,tp,code)
	return c:IsCode(code) and c:IsPreviousControler(tp) and c:IsReason(REASON_DESTROY)
end
function c87997872.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c87997872.cfilter,1,nil,tp,15013468)
		and eg:IsExists(c87997872.cfilter,1,nil,tp,51402177)
end
function c87997872.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c87997872.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false) end
	if c:IsLocation(LOCATION_DECK) then
		Duel.ConfirmCards(1-tp,c)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,tp,c:GetLocation())
end
function c87997872.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)~=0 then
		c:CompleteProcedure()
	end
end
function c87997872.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(3000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
