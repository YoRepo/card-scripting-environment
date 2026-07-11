--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: CXyz Battleship Cherry Blossom  (ID: 76419637)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Plant
-- Rank: 4
-- ATK 2400 | DEF 2000
-- Setcode: 0x1073
-- Scope: OCG / TCG
--
-- Effect Text:
-- 4 Level 4 monsters
-- Once per turn, during your opponent's End Phase, if your opponent has more cards in their hand than
-- you do: They discard 1 card.
-- If this card has "Battlecruiser Dianthus" as an Xyz Material, it gains this effect.
-- ● You can detach 1 Xyz Material from this card; inflict 300 damage to your opponent for each card on
-- the field.
-- You can only use this effect of "CXyz Battleship Cherry Blossom" once per turn.
--[[ __CARD_HEADER_END__ ]]

--CX 激烈華戦艦タオヤメ
function c76419637.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,4)
	c:EnableReviveLimit()
	--discard
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76419637,0))
	e1:SetCategory(CATEGORY_HANDES_OPPO)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c76419637.dccon)
	e1:SetTarget(c76419637.dctg)
	e1:SetOperation(c76419637.dcop)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(76419637,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,76419637)
	e2:SetCondition(c76419637.damcon)
	e2:SetCost(c76419637.damcost)
	e2:SetTarget(c76419637.damtg)
	e2:SetOperation(c76419637.damop)
	c:RegisterEffect(e2)
end
function c76419637.dccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
end
function c76419637.dctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_HANDES_OPPO,nil,0,1-tp,1)
end
function c76419637.dcop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardHand(1-tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
end
function c76419637.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,40424929)
end
function c76419637.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c76419637.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*300)
end
function c76419637.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetFieldGroupCount(p,LOCATION_ONFIELD,LOCATION_ONFIELD)
	Duel.Damage(p,ct*300,REASON_EFFECT)
end
