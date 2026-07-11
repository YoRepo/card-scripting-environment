--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: First Step Towards Infestation  (ID: 19932396)
-- Type: Spell / Quick-Play
-- Setcode: 0x65
-- Scope: OCG / TCG
--
-- Effect Text:
-- Return 1 face-up Tribute Summoned "Steelswarm" monster you control to the hand; draw 1 card.
--[[ __CARD_HEADER_END__ ]]

--侵略の一手
function c19932396.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c19932396.cost)
	e1:SetTarget(c19932396.target)
	e1:SetOperation(c19932396.activate)
	c:RegisterEffect(e1)
end
function c19932396.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x100a)
		and c:IsSummonType(SUMMON_TYPE_ADVANCE) and c:IsAbleToHandAsCost()
end
function c19932396.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c19932396.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c19932396.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_COST)
end
function c19932396.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c19932396.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
