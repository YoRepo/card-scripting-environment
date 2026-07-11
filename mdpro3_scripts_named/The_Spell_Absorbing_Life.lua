--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: The Spell Absorbing Life  (ID: 99517131)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Flip all face-down Defense Position Monster Cards on the field face-up.
-- Flip Effects are not activated at this time.
-- Increase your Life Points by 400 points for each Effect Monster Card on the field.
--[[ __CARD_HEADER_END__ ]]

--生命力吸収魔術
function c99517131.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c99517131.target)
	e1:SetOperation(c99517131.activate)
	c:RegisterEffect(e1)
end
function c99517131.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c99517131.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local rec=Duel.GetMatchingGroupCount(c99517131.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*400
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(rec)
	if rec>0 then Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec) end
end
function c99517131.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,true)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local rec=Duel.GetMatchingGroupCount(c99517131.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*400
	Duel.Recover(p,rec,REASON_EFFECT)
end
