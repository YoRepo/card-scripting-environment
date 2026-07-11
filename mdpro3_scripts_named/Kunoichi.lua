--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Kunoichi  (ID: 56514812)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level: 4
-- ATK 1800 | DEF 1000
-- Setcode: 0x66
-- Scope: OCG / TCG
--
-- Effect Text:
-- When control of this face-up card changes, its new controller discards 1 random card.
--[[ __CARD_HEADER_END__ ]]

--くノ一ウォリアー
function c56514812.initial_effect(c)
	--handes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(56514812,0))
	e1:SetCategory(CATEGORY_HANDES_SELF)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CONTROL_CHANGED)
	e1:SetTarget(c56514812.target)
	e1:SetOperation(c56514812.operation)
	c:RegisterEffect(e1)
end
function c56514812.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES_SELF,nil,0,ep,1)
end
function c56514812.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(ep,1)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
end
