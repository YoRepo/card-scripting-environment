--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 元素英雄 黑暗新宇侠  (ID: 28677304)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Warrior
-- Level 7
-- ATK 2500 | DEF 2000
-- Setcode: 602120
--
-- Effect Text:
-- 「元素英雄 新宇侠」＋「新空间侠·黑暗豹」
-- 把自己场上存在的上记的卡回到卡组的场合才能从额外卡组特殊召唤（不需要「融合」）。可以选择场上表侧表示存在的1只效果怪兽。只要这张卡在自己场上表侧表示存在，选择的怪兽直到从场上离开效果无效化（这个效果可
-- 以选择的怪兽最多1只）。结束阶段时这张卡回到额外卡组。
--[[ __CARD_HEADER_END__ ]]

--E・HERO ブラック・ネオス
function c28677304.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,89943723,43237273,false,false)
	aux.AddContactFusionProcedure(c,Card.IsAbleToDeckOrExtraAsCost,LOCATION_ONFIELD,0,aux.ContactFusionSendToDeck(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c28677304.splimit)
	c:RegisterEffect(e1)
	--return
	aux.EnableNeosReturn(c,c28677304.retop)
	--disable
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(28677304,1))
	e5:SetCategory(CATEGORY_DISABLE)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCondition(c28677304.discon)
	e5:SetTarget(c28677304.distg)
	e5:SetOperation(c28677304.disop)
	c:RegisterEffect(e5)
end
c28677304.material_setcode=0x8
function c28677304.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c28677304.retop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
function c28677304.discon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCardTargetCount()==0
end
function c28677304.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c28677304.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c28677304.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c28677304.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c28677304.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c28677304.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetCondition(c28677304.rcon)
		tc:RegisterEffect(e1,true)
	end
end
function c28677304.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
