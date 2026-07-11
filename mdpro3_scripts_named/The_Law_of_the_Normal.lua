--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: The Law of the Normal  (ID: 66926224)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can only activate this card while there are 5 face-up Level 2 or lower Normal Monsters on your
-- side of the field.
-- Both players discard all cards in their hands, and destroy all cards on the field except Level 2 or
-- lower Normal Monsters.
--[[ __CARD_HEADER_END__ ]]

--弱肉一色
function c66926224.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_HANDES_SELF+CATEGORY_HANDES_OPPO)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c66926224.condition)
	e1:SetTarget(c66926224.target)
	e1:SetOperation(c66926224.activate)
	c:RegisterEffect(e1)
end
function c66926224.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsLevelBelow(2)
end
function c66926224.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c66926224.cfilter,tp,LOCATION_MZONE,0,5,nil)
end
function c66926224.dfilter(c)
	return not (c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsLevelBelow(2))
end
function c66926224.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,c)
		and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0
		and Duel.IsExistingMatchingCard(c66926224.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local g=Duel.GetMatchingGroup(c66926224.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_HANDES_SELF,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_HANDES_OPPO,nil,0,1-tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c66926224.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	Duel.SendtoGrave(g1,REASON_EFFECT+REASON_DISCARD)
	local g2=Duel.GetMatchingGroup(c66926224.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(g2,REASON_EFFECT)
end
