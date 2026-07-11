--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: G Golem Dignified Trilithon  (ID: 50546029)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Cyberse
-- Link Rating: 4
-- Link Arrows: Top, Left, Right, Bottom
-- ATK 3200
-- Setcode: 0x186
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2+ EARTH monsters
-- All monsters your opponent controls must attack this card, if able.
-- Once per battle, if this card battles an opponent's monster, before damage calculation (Quick
-- Effect): You can send 1 EARTH monster from your hand to the GY; until the end of this turn, that
-- opponent's monster loses 200 ATK, also negate its effects.
-- When your opponent activates a card or effect that targets a Link Monster(s) you control (Quick
-- Effect): You can negate that effect, and if you do, destroy that card.
-- You can only use this effect of "G Golem Dignified Trilithon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--Gゴーレム・ディグニファイド・トリリトン
function c50546029.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkAttribute,ATTRIBUTE_EARTH),2)
	c:EnableReviveLimit()
	--must attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_MUST_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	e2:SetValue(c50546029.atklimit)
	c:RegisterEffect(e2)
	--atk down/disable
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(50546029,0))
	e3:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_CONFIRM)
	e3:SetCondition(c50546029.atkcon)
	e3:SetCost(c50546029.atkcost)
	e3:SetOperation(c50546029.atkop)
	c:RegisterEffect(e3)
	--disable
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(50546029,1))
	e4:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,50546029)
	e4:SetCondition(c50546029.discon)
	e4:SetTarget(c50546029.distg)
	e4:SetOperation(c50546029.disop)
	c:RegisterEffect(e4)
end
function c50546029.atklimit(e,c)
	return c==e:GetHandler()
end
function c50546029.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc and bc:IsFaceup() and bc:IsRelateToBattle() and bc:IsControler(1-tp)
end
function c50546029.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_EARTH) and c:IsAbleToGraveAsCost()
end
function c50546029.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c50546029.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c50546029.cfilter,1,1,REASON_COST)
end
function c50546029.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsFaceup() and bc:IsRelateToBattle() and bc:IsControler(1-tp) then
		Duel.NegateRelatedChain(bc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		bc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e3:SetValue(RESET_TURN_SET)
		bc:RegisterEffect(e3)
	end
end
function c50546029.acfilter(c,tp)
	return c:IsType(TYPE_LINK) and c:IsControler(tp) and c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsLocation(LOCATION_MZONE)
end
function c50546029.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return rp==1-tp and tg and tg:IsExists(c50546029.acfilter,1,nil,tp)
end
function c50546029.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c50546029.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
