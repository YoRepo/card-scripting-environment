--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: F.A. Shining Star GT  (ID: 37414347)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Machine
-- Link Rating: 2
-- Link Arrows: Bottom-Left, Bottom-Right
-- ATK 0
-- Setcode: 0x107
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Machine monsters
-- Gains ATK equal to the total Levels of the "F.A." monsters this card points to x 300.
-- Neither player takes any battle damage from attacks involving this card.
-- Each time a "F.A." Spell/Trap Card or effect is activated: Place 1 Athlete Counter on this card.
-- When your opponent activates a monster effect (Quick Effect): You can remove 1 Athlete Counter from
-- this card; negate the activation, and if you do, destroy it.
-- You can only use this effect of "F.A. Shining Star GT" once per turn.
--[[ __CARD_HEADER_END__ ]]

--F.A.シャイニングスターGT
function c37414347.initial_effect(c)
	c:EnableCounterPermit(0x4a)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_MACHINE),2,2)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c37414347.atkval)
	c:RegisterEffect(e1)
	--avoid damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--counter
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(37414347,0))
	e4:SetCategory(CATEGORY_COUNTER)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e4:SetCondition(c37414347.ctcon)
	e4:SetTarget(c37414347.cttg)
	e4:SetOperation(c37414347.ctop)
	c:RegisterEffect(e4)
	--negate
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(37414347,1))
	e5:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_CHAINING)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,37414347)
	e5:SetCondition(c37414347.discon)
	e5:SetCost(c37414347.discost)
	e5:SetTarget(c37414347.distg)
	e5:SetOperation(c37414347.disop)
	c:RegisterEffect(e5)
end
function c37414347.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x107) and c:GetLevel()>=0
end
function c37414347.atkval(e,c)
	local lg=c:GetLinkedGroup():Filter(c37414347.atkfilter,nil)
	return lg:GetSum(Card.GetLevel)*300
end
function c37414347.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and re:GetHandler():IsSetCard(0x107)
end
function c37414347.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x4a)
end
function c37414347.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		c:AddCounter(0x4a,1)
	end
end
function c37414347.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep==1-tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c37414347.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanRemoveCounter(tp,0x4a,1,REASON_COST) end
	c:RemoveCounter(tp,0x4a,1,REASON_COST)
end
function c37414347.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c37414347.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
