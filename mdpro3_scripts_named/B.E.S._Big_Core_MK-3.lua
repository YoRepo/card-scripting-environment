--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 巨大战舰 巨核Mk-3  (ID: 82821760)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 8
-- ATK 2700 | DEF 1900
-- Setcode: 21
--
-- Effect Text:
-- ①：只有对方场上才有怪兽存在的场合，这张卡可以从手卡守备表示特殊召唤。
-- ②：这张卡召唤·特殊召唤的场合发动。给这张卡放置3个指示物。
-- ③：这张卡不会被战斗破坏。
-- ④：这张卡进行战斗的伤害步骤结束时发动。这张卡1个指示物取除。不能取除的场合，这张卡破坏。
-- ⑤：把墓地的这张卡除外才能发动。自己墓地的「巨大战舰」怪兽全部回到卡组。
--[[ __CARD_HEADER_END__ ]]

--巨大戦艦 ビッグ・コアMk－Ⅲ
function c82821760.initial_effect(c)
	c:EnableCounterPermit(0x1f)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c82821760.sprcon)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(82821760,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c82821760.cttg)
	e2:SetOperation(c82821760.ctop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--remove counter
	aux.EnableBESRemove(c)
	--to deck
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(82821760,2))
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_GRAVE)
	e6:SetCost(aux.bfgcost)
	e6:SetTarget(c82821760.tdtg)
	e6:SetOperation(c82821760.tdop)
	c:RegisterEffect(e6)
end
function c82821760.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c82821760.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,3,0,0x1f)
end
function c82821760.ctop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x1f,3)
	end
end
function c82821760.tdfilter(c)
	return c:IsSetCard(0x15) and c:IsAbleToDeck()
end
function c82821760.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c82821760.tdfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c82821760.tdfilter,tp,LOCATION_GRAVE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c82821760.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c82821760.tdfilter,tp,LOCATION_GRAVE,0,nil)
	if aux.NecroValleyNegateCheck(g) then return end
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
