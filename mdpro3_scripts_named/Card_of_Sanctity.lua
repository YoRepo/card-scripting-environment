--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Card of Sanctity  (ID: 42664989)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Banish all other cards you control and in your hand (min.1 from each); draw until you have 2 cards
-- in your hand.
--[[ __CARD_HEADER_END__ ]]

--天よりの宝札
function c42664989.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c42664989.cost)
	e1:SetTarget(c42664989.target)
	e1:SetOperation(c42664989.operation)
	c:RegisterEffect(e1)
end
function c42664989.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_ONFIELD,0,e:GetHandler())
	if chk==0 then return g:GetCount()>0 and g:GetCount()==g:FilterCount(Card.IsAbleToRemoveAsCost,nil) end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c42664989.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp) end
	local ht=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2-ht)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2-ht)
end
function c42664989.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ht=Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
	if ht<2 then
		Duel.Draw(p,2-ht,REASON_EFFECT)
	end
end
