--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Battlecruiser Dianthus  (ID: 40424929)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Plant
-- Rank: 3
-- ATK 2100 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 3 monsters
-- You can detach 1 Xyz Material from this card; inflict 200 damage to your opponent for each card in
-- their hand.
-- You can only use this effect of "Battlecruiser Dianthus" once per turn.
--[[ __CARD_HEADER_END__ ]]

--烈華砲艦ナデシコ
function c40424929.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,3)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40424929,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,40424929)
	e1:SetCost(c40424929.damcost)
	e1:SetTarget(c40424929.damtg)
	e1:SetOperation(c40424929.damop)
	c:RegisterEffect(e1)
end
function c40424929.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c40424929.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*200)
end
function c40424929.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
	Duel.Damage(p,ct*200,REASON_EFFECT)
end
