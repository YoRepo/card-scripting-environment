--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 龙星因士-神数右枢  (ID: 96223501)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- Pendulum Scales: L1 / R1
-- ATK 0 | DEF 2100
-- Setcode: 10223812
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：自己不是「星骑士」怪兽以及「神数」怪兽不能灵摆召唤。这个效果不会被无效化。
-- 【怪兽效果】
-- 「龙星因士-神数右枢」的怪兽效果1回合只能使用1次。
-- ①：这张卡召唤·反转召唤·灵摆召唤成功的场合，以这张卡以外的自己的怪兽区域·灵摆区域1张「星骑士」卡或者「神数」卡和对方场上1张表侧表示的卡为对象才能发动。那些卡破坏。
--[[ __CARD_HEADER_END__ ]]

--竜星因士－セフィラツバーン
function c96223501.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c96223501.splimit)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCountLimit(1,96223501)
	e3:SetTarget(c96223501.target)
	e3:SetOperation(c96223501.operation)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetCondition(c96223501.condition)
	c:RegisterEffect(e5)
	c96223501.star_knight_summon_effect=e3
end
function c96223501.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0x9c,0xc4) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c96223501.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c96223501.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x9c,0xc4)
end
function c96223501.filter2(c)
	return c:IsFaceup()
end
function c96223501.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c96223501.filter1,tp,LOCATION_MZONE+LOCATION_PZONE,0,1,e:GetHandler())
		and Duel.IsExistingTarget(c96223501.filter2,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c96223501.filter1,tp,LOCATION_MZONE+LOCATION_PZONE,0,1,1,e:GetHandler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,c96223501.filter2,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function c96223501.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
