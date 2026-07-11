--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Number S39: Utopia Prime  (ID: 86532744)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Warrior
-- Rank: 4
-- ATK 2510 | DEF 2000
-- Setcode: 0x48, 0x107f
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 4 LIGHT monsters
-- You can also Xyz Summon this card by using "Number 39: Utopia" you control (transfer its materials
-- to this card).
-- If your opponent's LP is at least 3000 higher than yours: You can detach 3 materials from this card
-- and pay LP so that you only have 10 left; destroy as many Special Summoned monsters your opponent
-- controls as possible, and if you do, banish them, then inflict 300 damage to your opponent for each
-- monster banished.
--[[ __CARD_HEADER_END__ ]]

--SNo.39 希望皇ホープONE
function c86532744.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT),4,3,c86532744.ovfilter,aux.Stringid(86532744,1))
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetDescription(aux.Stringid(86532744,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c86532744.condition)
	e1:SetCost(c86532744.cost)
	e1:SetTarget(c86532744.target)
	e1:SetOperation(c86532744.operation)
	c:RegisterEffect(e1)
end
aux.xyz_number[86532744]=39
function c86532744.ovfilter(c)
	return c:IsFaceup() and c:IsCode(84013237)
end
function c86532744.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=Duel.GetLP(1-tp)-3000
end
function c86532744.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local lp=Duel.GetLP(tp)
	if chk==0 then return Duel.CheckLPCost(tp,lp-10) and e:GetHandler():CheckRemoveOverlayCard(tp,3,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,3,3,REASON_COST)
	Duel.PayLPCost(tp,lp-10)
end
function c86532744.filter(c)
	return c:IsAbleToRemove()
		and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c86532744.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c86532744.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c86532744.filter,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c86532744.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,sg:GetCount()*300)
end
function c86532744.ctfilter(c)
	return c:IsLocation(LOCATION_REMOVED) and not c:IsReason(REASON_REDIRECT)
end
function c86532744.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c86532744.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT,LOCATION_REMOVED)
	local ct=Duel.GetOperatedGroup():FilterCount(c86532744.ctfilter,nil)
	if ct>0 then
		Duel.BreakEffect()
		Duel.Damage(1-tp,ct*300,REASON_EFFECT)
	end
end
