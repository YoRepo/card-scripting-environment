--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 元素英雄 天空新宇侠  (ID: 11502550)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Warrior
-- Level 7
-- ATK 2500 | DEF 2000
-- Setcode: 602120
--
-- Effect Text:
-- 「元素英雄 新宇侠」＋「新空间侠·天空蜂鸟」
-- 把自己场上存在的上记的卡回到卡组的场合才能从额外卡组特殊召唤（不需要「融合」）。自己基本分比对方基本分少的场合，这张卡的攻击力上升那个数值。结束阶段时这张卡回到额外卡组。
--[[ __CARD_HEADER_END__ ]]

--E・HERO エアー・ネオス
function c11502550.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,89943723,54959865,false,false)
	aux.AddContactFusionProcedure(c,Card.IsAbleToDeckOrExtraAsCost,LOCATION_ONFIELD,0,aux.ContactFusionSendToDeck(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c11502550.splimit)
	c:RegisterEffect(e1)
	--return
	aux.EnableNeosReturn(c,c11502550.retop)
	--atkup
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(c11502550.atkval)
	c:RegisterEffect(e5)
end
c11502550.material_setcode=0x8
function c11502550.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c11502550.retop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
function c11502550.atkval(e,c)
	local lps=Duel.GetLP(c:GetControler())
	local lpo=Duel.GetLP(1-c:GetControler())
	if lps>=lpo then return 0
	else return lpo-lps end
end
