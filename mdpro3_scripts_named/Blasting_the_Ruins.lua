--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Blasting the Ruins  (ID: 21466326)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can only activate this card if there are 30 or more cards in your Graveyard.
-- Inflict 3000 points of damage to your opponent's Life Points.
--[[ __CARD_HEADER_END__ ]]

--残骸爆破
function c21466326.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c21466326.condition)
	e1:SetTarget(c21466326.target)
	e1:SetOperation(c21466326.activate)
	c:RegisterEffect(e1)
end
function c21466326.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)>=30
end
function c21466326.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(3000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,3000)
end
function c21466326.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
