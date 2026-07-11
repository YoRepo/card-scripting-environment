--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Silent Abyss  (ID: 86442081)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level: 7
-- ATK 2000 | DEF 1500
-- Setcode: 0x75
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is destroyed by battle and sent to the Graveyard, destroy all face-down and non-WATER
-- monsters.
--[[ __CARD_HEADER_END__ ]]

--サイレントアビス
function c86442081.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86442081,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c86442081.condition)
	e1:SetTarget(c86442081.target)
	e1:SetOperation(c86442081.operation)
	c:RegisterEffect(e1)
end
function c86442081.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c86442081.filter(c)
	return (c:IsFacedown() or c:GetAttribute()~=ATTRIBUTE_WATER)
end
function c86442081.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c86442081.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c86442081.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c86442081.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
