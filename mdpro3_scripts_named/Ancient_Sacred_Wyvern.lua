--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 古代圣翼龙  (ID: 25958491)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Fairy
-- Level 7
-- ATK 2100 | DEF 2000
--
-- Effect Text:
-- 光属性调整＋调整以外的怪兽1只以上
-- 自己基本分比对方高的场合，这张卡的攻击力上升那个数值。自己基本分比对方低的场合，这张卡的攻击力下降那个数值。这张卡被战斗破坏送去墓地时，可以支付1000基本分把这张卡在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--エンシェント・ホーリー・ワイバーン
function c25958491.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--Atk update
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c25958491.atkval)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(25958491,0))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c25958491.sumcon)
	e2:SetCost(c25958491.sumcost)
	e2:SetTarget(c25958491.sumtg)
	e2:SetOperation(c25958491.sumop)
	c:RegisterEffect(e2)
end
function c25958491.atkval(e,c)
	local cont=c:GetControler()
	return Duel.GetLP(cont)-Duel.GetLP(1-cont)
end
function c25958491.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c25958491.sumcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c25958491.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c25958491.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
