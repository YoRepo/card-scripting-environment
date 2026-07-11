--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Mild Turkey  (ID: 47558785)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Winged Beast
-- Level: 4
-- ATK 1000 | DEF 2000
-- Pendulum Scale: L7 / R7
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 7
-- [ Pendulum Effect ]
-- Once per turn: You can roll a six-sided die. Until the end of this turn, reduce this card's Pendulum
-- Scale by that number (min. 1).
-- ----------------------------------------
-- [ Monster Effect ]
-- The taste of victory will bowl you over.
--[[ __CARD_HEADER_END__ ]]

--マイルド・ターキー
function c47558785.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--scale change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47558785,0))
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c47558785.sctg)
	e1:SetOperation(c47558785.scop)
	c:RegisterEffect(e1)
end
function c47558785.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetLeftScale()>1 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c47558785.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:GetLeftScale()<=1 then return end
	local dc=Duel.TossDice(tp,1)
	local sch=math.min(c:GetLeftScale()-1,dc)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LSCALE)
	e1:SetValue(-sch)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_RSCALE)
	c:RegisterEffect(e2)
end
