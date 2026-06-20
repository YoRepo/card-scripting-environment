--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 龙穴之魔术师  (ID: 51531505)
-- Type: Monster / Normal / Pendulum
-- Attribute: WATER
-- Race: Spellcaster
-- Level 7
-- Pendulum Scales: L8 / R8
-- ATK 900 | DEF 2700
-- Setcode: 152
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- ①：1回合1次，另一边的自己的灵摆区域有「魔术师」卡存在的场合，把手卡1只灵摆怪兽丢弃，以场上1张魔法·陷阱卡为对象才能发动。那张卡破坏。
-- 【怪兽描述】
-- 年纪轻轻就领会唤醒龙魂的神通力的天才魔术师。由于他沉默寡言加上清心寡欲这种对魔术的态度而不擅长与人交际，但总被徒弟「龙脉之魔术师」折腾到抓狂。
--[[ __CARD_HEADER_END__ ]]

--竜穴の魔術師
function c51531505.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51531505,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c51531505.condition)
	e2:SetCost(c51531505.cost)
	e2:SetTarget(c51531505.target)
	e2:SetOperation(c51531505.operation)
	c:RegisterEffect(e2)
end
function c51531505.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,1,e:GetHandler(),0x98)
end
function c51531505.cfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsDiscardable()
end
function c51531505.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51531505.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c51531505.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c51531505.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c51531505.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c51531505.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51531505.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c51531505.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c51531505.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
