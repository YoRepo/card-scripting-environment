--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 龙脉之魔术师  (ID: 15146890)
-- Type: Monster / Normal / Pendulum
-- Attribute: EARTH
-- Race: Spellcaster
-- Level 4
-- Pendulum Scales: L1 / R1
-- ATK 1800 | DEF 900
-- Setcode: 152
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：1回合1次，另一边的自己的灵摆区域有「魔术师」卡存在的场合，把手卡1只灵摆怪兽丢弃，以场上1只表侧表示怪兽为对象才能发动。那只怪兽破坏。
-- 【怪兽描述】
-- 优点只有精力充沛的新手少年魔术师。其实有着无意识间觉察到大地长眠的龙魂这种能力，虽然还是半吊子但其资质之高就连师父「龙穴之魔术师」也自认不如。
--[[ __CARD_HEADER_END__ ]]

--竜脈の魔術師
function c15146890.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(15146890,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c15146890.condition)
	e2:SetCost(c15146890.cost)
	e2:SetTarget(c15146890.target)
	e2:SetOperation(c15146890.operation)
	c:RegisterEffect(e2)
end
function c15146890.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,1,e:GetHandler(),0x98)
end
function c15146890.cfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsDiscardable()
end
function c15146890.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c15146890.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c15146890.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c15146890.filter(c)
	return c:IsFaceup()
end
function c15146890.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c15146890.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c15146890.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c15146890.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c15146890.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
