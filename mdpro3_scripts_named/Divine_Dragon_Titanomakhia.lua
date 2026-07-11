--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Divine Dragon Titanomakhia  (ID: 32975247)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 10
-- ATK 3000 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- This Special Summoned card cannot be destroyed by battle.
-- You can only use each of the following effects of "Divine Dragon Titanomakhia" once per turn.
-- You can banish 3 "Divine Dragon Titanomakhia" from your GY and/or face-up field, including this card
-- on the field; destroy all cards your opponent controls.
-- During the End Phase: You can send cards from the top of your Deck to your GY, equal to the number
-- of Dragon monsters you control.
--[[ __CARD_HEADER_END__ ]]

--神竜 ティタノマキア
local s,id,o=GetID()
function c32975247.initial_effect(c)
	--indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c32975247.indcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32975247,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,32975247)
	e2:SetCost(c32975247.descost)
	e2:SetTarget(c32975247.destg)
	e2:SetOperation(c32975247.desop)
	c:RegisterEffect(e2)
	--discard deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(32975247,1))
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1,32975247+o)
	e3:SetTarget(c32975247.distg)
	e3:SetOperation(c32975247.disop)
	c:RegisterEffect(e3)
end
function c32975247.indcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c32975247.costfilter(c)
	return c:IsCode(32975247) and c:IsAbleToRemoveAsCost() and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function c32975247.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c32975247.costfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,c)
	if chk==0 then return c:IsAbleToRemoveAsCost() and g:GetCount()>=2 end
	local sg
	if #g==2 then
		sg=g
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		sg=g:Select(tp,2,2,nil)
	end
	sg:AddCard(c)
	Duel.Remove(sg,POS_FACEUP,REASON_COST)
end
function c32975247.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c32975247.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c32975247.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c32975247.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c32975247.cfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,ct) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,ct)
end
function c32975247.disop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c32975247.cfilter,tp,LOCATION_MZONE,0,nil)
	if ct>0 then
		Duel.DiscardDeck(tp,ct,REASON_EFFECT)
	end
end
