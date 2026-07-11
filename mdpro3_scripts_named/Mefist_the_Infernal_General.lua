--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Mefist the Infernal General  (ID: 46820049)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 5
-- ATK 1800 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks a Defense Position monster, inflict piercing battle damage.
-- If this card inflicts battle damage to your opponent: Make your opponent discard 1 random card.
--[[ __CARD_HEADER_END__ ]]

--地獄将軍・メフィスト
function c46820049.initial_effect(c)
	--handes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46820049,0))
	e1:SetCategory(CATEGORY_HANDES_OPPO)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c46820049.condition)
	e1:SetTarget(c46820049.target)
	e1:SetOperation(c46820049.operation)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c46820049.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c46820049.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES_OPPO,nil,0,1-tp,1)
end
function c46820049.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(ep,1)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
end
