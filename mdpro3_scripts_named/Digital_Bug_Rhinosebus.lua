--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Digital Bug Rhinosebus  (ID: 85004150)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Insect
-- Rank: 7
-- ATK 2600 | DEF 2200
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 or more Level 7 LIGHT Insect-Type monsters
-- You can also Xyz Summon this card by detaching 2 Xyz Materials from a Rank 5 or 6 Insect-Type Xyz
-- Monster you control, then using that Xyz Monster as the Xyz Material.
-- (Xyz Materials attached to that monster also become Xyz Materials on this card.)
-- If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
-- Once per turn, during either player's turn: You can detach 1 Xyz Material from this card; destroy
-- the face-up monster(s) your opponent controls with the highest DEF (all, if tied).
--[[ __CARD_HEADER_END__ ]]

--電子光虫－ライノセバス
function c85004150.initial_effect(c)
	c:EnableReviveLimit()
	--xyz summon
	aux.AddXyzProcedure(c,c85004150.mfilter,7,2,c85004150.ovfilter,aux.Stringid(85004150,0),99,c85004150.xyzop)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85004150,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c85004150.descost)
	e2:SetTarget(c85004150.destg)
	e2:SetOperation(c85004150.desop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
end
function c85004150.ovfilter(c)
	return c:IsFaceup() and c:IsXyzType(TYPE_XYZ) and c:IsRank(5,6) and c:IsRace(RACE_INSECT)
end
function c85004150.mfilter(c)
	return c:IsRace(RACE_INSECT) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c85004150.xyzop(e,tp,chk,mc)
	if chk==0 then return mc:CheckRemoveOverlayCard(tp,2,REASON_COST) end
	mc:RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c85004150.desfilter(c)
	return c:IsFaceup() and c:IsDefenseAbove(0)
end
function c85004150.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c85004150.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c85004150.desfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c85004150.desfilter,tp,0,LOCATION_MZONE,nil)
	local dg=g:GetMaxGroup(Card.GetDefense)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c85004150.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c85004150.desfilter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local dg=g:GetMaxGroup(Card.GetDefense)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
