--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 剑斗兽 希拉克略  (ID: 27346636)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level 8
-- ATK 3000 | DEF 2800
-- Setcode: 4121
--
-- Effect Text:
-- 「剑斗兽 绳斗」＋名字带有「剑斗兽」的怪兽×2
-- 让自己场上的上记的卡回到卡组的场合才能从额外卡组特殊召唤（不需要「融合」魔法卡）。只要这张卡在场上表侧表示存在，可以通过丢弃1张手卡，魔法·陷阱卡的发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--剣闘獣ヘラクレイノス
function c27346636.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,78868776,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1019),2,true,true)
	aux.AddContactFusionProcedure(c,c27346636.cfilter,LOCATION_ONFIELD,0,aux.ContactFusionSendToDeck(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c27346636.splimit)
	c:RegisterEffect(e1)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(27346636,0))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCondition(c27346636.discon)
	e3:SetCost(c27346636.discost)
	e3:SetTarget(c27346636.distg)
	e3:SetOperation(c27346636.disop)
	c:RegisterEffect(e3)
end
function c27346636.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c27346636.cfilter(c)
	return (c:IsFusionCode(78868776) or c:IsFusionSetCard(0x1019) and c:IsType(TYPE_MONSTER))
		and c:IsAbleToDeckOrExtraAsCost()
end
function c27346636.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c27346636.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c27346636.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c27346636.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
