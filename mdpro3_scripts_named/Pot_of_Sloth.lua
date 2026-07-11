--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Pot of Sloth  (ID: 98476659)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Draw cards equal to the number of cards your opponent controls, then if you drew 2 or more cards,
-- place cards from your hand on the bottom of the Deck in any order, equal to the number you drew -1.
-- For the rest of this turn after this card resolves, you cannot activate "Pot of Sloth".
--[[ __CARD_HEADER_END__ ]]

--怠慢な壺
local s,id=GetID()
function s.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.condition(_,tp)
	return Duel.GetFlagEffect(tp,id)==0
end
function s.target(_,tp,_,_,_,_,_,_,chk)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function s.activate(e,tp)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
	end
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetFieldGroupCount(p,0,LOCATION_ONFIELD)
	if ct<=0 then return end
	local drawn=Duel.Draw(p,ct,REASON_EFFECT)
	if drawn>=2 then
		local ret=drawn-1
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(p,Card.IsAbleToDeck,p,LOCATION_HAND,0,ret,ret,nil)
		Duel.ShuffleHand(p)
		aux.PlaceCardsOnDeckBottom(p,g)
	end
end
