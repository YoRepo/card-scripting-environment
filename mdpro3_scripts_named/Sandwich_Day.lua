--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Sandwich Day  (ID: 83838727)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you have a monster in your GY: Pay 200 LP; draw 1 card and reveal it, then, if it is a monster,
-- apply this effect based on its Attribute.
-- ● An Attribute not in your GY: Draw 1 card.
-- ● An Attribute in your GY: Discard 1 card.
-- You can only activate 1 "Sandwich Day" per turn.
--[[ __CARD_HEADER_END__ ]]

--ドローパン
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_HANDES_SELF+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.condition)
	e1:SetCost(s.cost)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_MONSTER)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,200) end
	Duel.PayLPCost(tp,200)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)~=0 then
		local g=Duel.GetOperatedGroup()
		local tc=g:GetFirst()
		Duel.ConfirmCards(1-p,tc)
		if not tc:IsType(TYPE_MONSTER) then
			Duel.ShuffleHand(p)
			return
		end
		Duel.BreakEffect()
		if Duel.IsExistingMatchingCard(Card.IsAttribute,p,LOCATION_GRAVE,0,1,nil,tc:GetAttribute()) then
			local sg=Duel.GetMatchingGroup(Card.IsDiscardable,p,LOCATION_HAND,0,nil,REASON_EFFECT+REASON_DISCARD)
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_DISCARD)
			local dg=sg:Select(p,1,1,nil)
			Duel.ShuffleHand(p)
			Duel.SendtoGrave(dg,REASON_EFFECT+REASON_DISCARD)
		else
			Duel.Draw(p,1,REASON_EFFECT)
		end
		Duel.ShuffleHand(p)
	end
end
