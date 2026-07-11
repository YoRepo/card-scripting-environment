--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Chow Chow Chan  (ID: 99902789)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 2
-- ATK 800 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent activates a Normal Trap Card in response to your monster's attack declaration
-- targeting an opponent's monster: You can discard this card; negate the activation, and if you do,
-- destroy that card (this is a Quick Effect).
--[[ __CARD_HEADER_END__ ]]

--チャウチャウちゃん
function c99902789.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99902789,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c99902789.discon)
	e1:SetCost(c99902789.discost)
	e1:SetTarget(c99902789.distg)
	e1:SetOperation(c99902789.disop)
	c:RegisterEffect(e1)
end
function c99902789.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and Duel.GetAttacker():IsControler(tp) and Duel.GetAttackTarget()~=nil
		and ep~=tp and re:GetActiveType()==TYPE_TRAP and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c99902789.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c99902789.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c99902789.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
