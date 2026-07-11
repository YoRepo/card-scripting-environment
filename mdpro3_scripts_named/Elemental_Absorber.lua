--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Elemental Absorber  (ID: 94253609)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Remove from play 1 Monster Card in your hand to activate this card.
-- Your opponent's monsters that have the same Attribute as the monster removed by this effect cannot
-- declare an attack.
--[[ __CARD_HEADER_END__ ]]

--エレメンタル・アブソーバー
function c94253609.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c94253609.cost)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c94253609.atktarget)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c94253609.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c94253609.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c94253609.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c94253609.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	local att=g:GetFirst():GetAttribute()
	e:GetLabelObject():SetLabel(att)
	e:GetHandler():SetHint(CHINT_ATTRIBUTE,att)
end
function c94253609.atktarget(e,c)
	return c:IsAttribute(e:GetLabel())
end
