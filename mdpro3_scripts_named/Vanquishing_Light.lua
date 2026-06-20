--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 光之放逐  (ID: 32233746)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上存在的1只名字带有「光道」的怪兽解放发动。怪兽的召唤·反转召唤·特殊召唤无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--ライト・バニッシュ
function c32233746.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(aux.NegateSummonCondition)
	e1:SetCost(c32233746.cost)
	e1:SetTarget(c32233746.target)
	e1:SetOperation(c32233746.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
end
function c32233746.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x38) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x38)
	Duel.Release(g,REASON_COST)
end
function c32233746.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c32233746.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
