--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Ghost Beef  (ID: 84046493)
-- Type: Monster / Normal / Pendulum
-- Attribute: DARK
-- Race: Beast
-- Level: 7
-- ATK 2000 | DEF 1000
-- Pendulum Scale: L4 / R4
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 4
-- [ Pendulum Effect ]
-- Once per turn: You can roll a six-sided die. Until the end of this turn, increase this card's
-- Pendulum Scale by that number (max. 10).
-- ----------------------------------------
-- [ Monster Effect ]
-- The Ghost of Christmas Dinner.
--[[ __CARD_HEADER_END__ ]]

--ゴースト・ビーフ
function c84046493.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--scale change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84046493,0))
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c84046493.sctg)
	e1:SetOperation(c84046493.scop)
	c:RegisterEffect(e1)
end
function c84046493.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetLeftScale()<10 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c84046493.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:GetLeftScale()>=10 then return end
	local dc=Duel.TossDice(tp,1)
	local sch=math.min(10-c:GetLeftScale(),dc)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LSCALE)
	e1:SetValue(sch)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_RSCALE)
	c:RegisterEffect(e2)
end
