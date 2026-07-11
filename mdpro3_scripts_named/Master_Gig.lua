--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Master Gig  (ID: 16191953)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Psychic
-- Level: 8
-- ATK 2600 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can pay 1000 Life Points to destroy monsters your opponent controls equal to the
-- number of face-up Psychic-Type monsters you control.
--[[ __CARD_HEADER_END__ ]]

--マスター・ジーグ
function c16191953.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16191953,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c16191953.cost)
	e1:SetTarget(c16191953.target)
	e1:SetOperation(c16191953.operation)
	c:RegisterEffect(e1)
end
function c16191953.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c16191953.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PSYCHO)
end
function c16191953.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c16191953.filter,tp,LOCATION_MZONE,0,nil)<=Duel.GetMatchingGroupCount(aux.TRUE,tp,0,LOCATION_MZONE,nil) end
	local ct=Duel.GetMatchingGroupCount(c16191953.filter,tp,LOCATION_MZONE,0,nil)
	local dg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,ct,0,0)
end
function c16191953.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c16191953.filter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	if ct>g:GetCount() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=g:Select(tp,ct,ct,nil)
	Duel.HintSelection(dg)
	Duel.Destroy(dg,REASON_EFFECT)
end
