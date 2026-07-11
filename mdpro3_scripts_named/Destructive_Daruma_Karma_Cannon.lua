--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Destructive Daruma Karma Cannon  (ID: 30748475)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Change as many monsters on the field as possible to face-down Defense Position, then, if either
-- player controls a face-up monster(s), they must send all face-up monsters they control to the GY.
--[[ __CARD_HEADER_END__ ]]

--魔砲戦機ダルマ・カルマ
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_TOGRAVE+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsCanTurnSet,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,#g,0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)<1 then return end
	local tg=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	for p=0,1 do
		if not Duel.IsPlayerCanSendtoGrave(p) then tg:Remove(Card.IsControler,nil,p) end
	end
	if #tg>0 then
		Duel.BreakEffect()
		for p in aux.TurnPlayers() do
			local sg=tg:Filter(Card.IsControler,nil,p)
			Duel.SendtoGrave(sg,REASON_RULE,p)
		end
	end
end
