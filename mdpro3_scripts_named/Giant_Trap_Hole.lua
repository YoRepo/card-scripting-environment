--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Giant Trap Hole  (ID: 80723580)
-- Type: Trap
-- Setcode: 0x4c
-- Scope: OCG / TCG
--
-- Effect Text:
-- When 2 or more monsters are Special Summoned at the same time: Destroy all monsters on the field.
--[[ __CARD_HEADER_END__ ]]

--大落とし穴
function c80723580.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c80723580.condition)
	e1:SetTarget(c80723580.target)
	e1:SetOperation(c80723580.activate)
	c:RegisterEffect(e1)
end
function c80723580.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetCount()>=2
end
function c80723580.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c80723580.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
