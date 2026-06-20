--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 元素英雄 风暴新宇侠  (ID: 49352945)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Warrior
-- Level 9
-- ATK 3000 | DEF 2500
-- Setcode: 602120
--
-- Effect Text:
-- 「元素英雄 新宇侠」＋「新空间侠·水波海豚」＋「新空间侠·天空蜂鸟」
-- 把自己场上存在的上记的卡回到卡组的场合才能从额外卡组特殊召唤（不需要「融合」）。1回合只有1次在自己的主要阶段时可以把场上的魔法·陷阱卡全部破坏。结束阶段时这张卡回到额外卡组。这个效果回到额外卡组时，
-- 场上存在的全部卡回到卡组洗切。
--[[ __CARD_HEADER_END__ ]]

--E・HERO ストーム・ネオス
function c49352945.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,89943723,17955766,54959865,false,false)
	aux.AddContactFusionProcedure(c,Card.IsAbleToDeckOrExtraAsCost,LOCATION_ONFIELD,0,aux.ContactFusionSendToDeck(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c49352945.splimit)
	c:RegisterEffect(e1)
	--return
	local e3,e4=aux.EnableNeosReturn(c,c49352945.retop)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(49352945,1))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c49352945.destg)
	e5:SetOperation(c49352945.desop)
	c:RegisterEffect(e5)
	--todeck
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(49352945,2))
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_TO_DECK)
	e6:SetCondition(c49352945.tdcon)
	e6:SetTarget(c49352945.tdtg)
	e6:SetOperation(c49352945.tdop)
	c:RegisterEffect(e6)
	e3:SetLabelObject(e6)
	e4:SetLabelObject(e6)
end
c49352945.material_setcode=0x8
function c49352945.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c49352945.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
function c49352945.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c49352945.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c49352945.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c49352945.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c49352945.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c49352945.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c49352945.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return re:GetLabelObject()==e
end
function c49352945.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c49352945.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
