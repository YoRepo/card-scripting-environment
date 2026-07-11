--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Anchamoufrite  (ID: 52296675)
-- Type: Monster / Effect / Pendulum / Special Summon
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 5
-- ATK 1800 | DEF 0
-- Pendulum Scale: L4 / R4
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 4
-- [ Pendulum Effect ]
-- If you have no cards in your Extra Deck except "Anchamoufrite": You can destroy this card, then draw
-- 1 card.
-- You can only use this effect of "Anchamoufrite" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- Cannot be Normal Summoned/Set.
-- Must be Special Summoned (from your face-up Extra Deck) by having no cards in your Extra Deck except
-- "Anchamoufrite".
-- You can only Special Summon "Anchamoufrite" once per turn this way.
-- If this face-up card in the Monster Zone leaves the field, banish it.
--[[ __CARD_HEADER_END__ ]]

--アンカモフライト
function c52296675.initial_effect(c)
	c:EnableReviveLimit()
	aux.EnablePendulumAttribute(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52296675,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,52296675)
	e1:SetCondition(c52296675.drcon)
	e1:SetTarget(c52296675.drtg)
	e1:SetOperation(c52296675.drop)
	c:RegisterEffect(e1)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SPSUMMON_PROC)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_EXTRA)
	e3:SetCountLimit(1,52296676+EFFECT_COUNT_CODE_OATH)
	e3:SetCondition(c52296675.hspcon)
	c:RegisterEffect(e3)
	--redirect
	aux.AddBanishRedirect(c,c52296675.recon)
end
function c52296675.drfilter(c)
	return c:IsFaceup() and c:IsCode(52296675)
end
function c52296675.drcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)
	return ct==0 or ct==Duel.GetMatchingGroupCount(c52296675.drfilter,tp,LOCATION_EXTRA,0,nil)
end
function c52296675.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c52296675.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c52296675.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)
	return ct==Duel.GetMatchingGroupCount(c52296675.drfilter,tp,LOCATION_EXTRA,0,nil) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c52296675.recon(e)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup()
end
