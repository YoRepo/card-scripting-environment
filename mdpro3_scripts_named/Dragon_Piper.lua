--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Dragon Piper  (ID: 55763552)
-- Type: Monster / Effect / Flip
-- Attribute: FIRE
-- Race: Pyro
-- Level: 3
-- ATK 200 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Destroy all face-up "Dragon Capture Jar"(s) on the field.
-- If you destroy any, change all face-up Dragon-Type monsters on the field to Attack Position.
--[[ __CARD_HEADER_END__ ]]

--壺魔人
function c55763552.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55763552,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c55763552.target)
	e1:SetOperation(c55763552.operation)
	c:RegisterEffect(e1)
end
function c55763552.filter(c)
	return c:IsFaceup() and c:IsCode(50045299)
end
function c55763552.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c55763552.filter,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c55763552.pfilter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsRace(RACE_DRAGON)
end
function c55763552.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c55763552.filter,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		local pg=Duel.GetMatchingGroup(c55763552.pfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		Duel.ChangePosition(pg,POS_FACEUP_ATTACK)
	end
end
