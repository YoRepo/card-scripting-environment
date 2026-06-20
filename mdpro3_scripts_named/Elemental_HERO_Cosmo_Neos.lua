--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 元素英雄 秩序新宇侠  (ID: 90050480)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 11
-- ATK 3500 | DEF 3000
-- Setcode: 602120
--
-- Effect Text:
-- 「元素英雄 新宇侠」＋属性不同的「新空间侠」怪兽×3
-- 让自己场上的上记卡回到卡组的场合才能从额外卡组特殊召唤（不需要「融合」）。
-- ①：这张卡从额外卡组的特殊召唤成功的场合才能发动。这个回合对方不能把场上发动的效果发动。对方不能对应这个效果的发动把魔法·陷阱·怪兽的效果发动。
-- ②：结束阶段发动。这张卡回到额外卡组，对方场上的卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--E・HERO コスモ・ネオス
function c90050480.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,89943723,c90050480.ffilter,3,true,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToDeckOrExtraAsCost,LOCATION_ONFIELD,0,aux.ContactFusionSendToDeck(c))
	--special summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(c90050480.splimit)
	c:RegisterEffect(e1)
	--return
	aux.EnableNeosReturn(c,c90050480.retop,c90050480.set_category)
	--act limit
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(90050480,1))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCondition(c90050480.limcon)
	e5:SetTarget(c90050480.limtg)
	e5:SetOperation(c90050480.limop)
	c:RegisterEffect(e5)
end
c90050480.material_setcode=0x8
function c90050480.ffilter(c,fc,sub,mg,sg)
	return c:IsType(TYPE_MONSTER) and c:IsFusionSetCard(0x1f) and (not sg or not sg:Filter(Card.IsFusionSetCard,nil,0x1f):IsExists(Card.IsFusionAttribute,1,c,c:GetFusionAttribute()))
end
function c90050480.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c90050480.set_category(e,tp,eg,ep,ev,re,r,rp)
	e:SetCategory(CATEGORY_TODECK+CATEGORY_DESTROY)
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c90050480.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	if c:IsLocation(LOCATION_EXTRA) then
		local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_ONFIELD,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c90050480.limcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonLocation(LOCATION_EXTRA)
end
function c90050480.limtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetChainLimit(c90050480.chainlm)
end
function c90050480.chainlm(e,rp,tp)
	return tp==rp
end
function c90050480.limop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(c90050480.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c90050480.aclimit(e,re,tp)
	return re:GetHandler():IsOnField() or re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
