--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Lady Assailant of Flames  (ID: 90147755)
-- Type: Monster / Effect / Flip
-- Attribute: FIRE
-- Race: Pyro
-- Level: 4
-- ATK 1500 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Banish the top 3 cards of your Deck; inflict 800 damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--炎の女暗殺者
function c90147755.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90147755,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetCost(c90147755.cost)
	e1:SetTarget(c90147755.target)
	e1:SetOperation(c90147755.operation)
	c:RegisterEffect(e1)
end
function c90147755.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_DECK,0,3,nil) end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c90147755.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c90147755.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
