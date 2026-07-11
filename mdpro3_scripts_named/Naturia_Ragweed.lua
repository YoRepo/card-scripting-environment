--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Naturia Ragweed  (ID: 87649699)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 3
-- ATK 1200 | DEF 2000
-- Setcode: 0x2a
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent draws a card(s) (except during the Draw Phase or Damage Step): You can send this
-- card from the field to the GY; draw 2 cards.
--[[ __CARD_HEADER_END__ ]]

--ナチュル・ラグウィード
function c87649699.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87649699,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c87649699.condition)
	e1:SetCost(c87649699.cost)
	e1:SetTarget(c87649699.target)
	e1:SetOperation(c87649699.operation)
	c:RegisterEffect(e1)
end
function c87649699.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetCurrentPhase()~=PHASE_DRAW
end
function c87649699.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c87649699.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c87649699.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
