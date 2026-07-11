--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Dream Mirror Oneiromancy  (ID: 61459246)
-- Type: Trap / Counter
-- Setcode: 0x131
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate 1 of these effects.
-- ● When your opponent activates a Spell/Trap Card while a "Dream Mirror of Joy" is in a Field Zone:
-- Negate the activation, and if you do, destroy that card.
-- ● When your opponent would Special Summon monster(s) while a "Dream Mirror of Terror" is in a Field
-- Zone: Negate the Summon, and if you do, destroy that monster.
-- You can only activate 1 "Dream Mirror Oneiromancy" per turn.
--[[ __CARD_HEADER_END__ ]]

--夢魔鏡の夢占い
function c61459246.initial_effect(c)
	aux.AddCodeList(c,74665651,1050355)
	--activate(effect)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,61459246+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c61459246.condition1)
	e1:SetTarget(c61459246.target1)
	e1:SetOperation(c61459246.activate1)
	c:RegisterEffect(e1)
	--activate(spsummon)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_SPSUMMON)
	e2:SetCountLimit(1,61459246+EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(c61459246.condition2)
	e2:SetTarget(c61459246.target2)
	e2:SetOperation(c61459246.activate2)
	c:RegisterEffect(e2)
end
function c61459246.condition1(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and rp==1-tp and Duel.IsEnvironment(74665651,PLAYER_ALL,LOCATION_FZONE)
end
function c61459246.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c61459246.activate1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c61459246.condition2(e,tp,eg,ep,ev,re,r,rp)
	return aux.NegateSummonCondition() and rp==1-tp and Duel.IsEnvironment(1050355,PLAYER_ALL,LOCATION_FZONE)
end
function c61459246.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c61459246.activate2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
