--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 邪心英雄 闪电巨魔  (ID: 21947653)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Fiend
-- Level 6
-- ATK 2400 | DEF 1500
-- Setcode: 24584
--
-- Effect Text:
-- 「元素英雄 电光侠」＋「元素英雄 黏土侠」
-- 这张卡用「暗黑融合」的效果才能特殊召唤。
-- ①：1回合1次，以场上1只怪兽为对象才能发动。那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--E-HERO ライトニング・ゴーレム
function c21947653.initial_effect(c)
	aux.AddCodeList(c,94820406)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,20721928,84327329,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.DarkFusionLimit)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21947653,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c21947653.target)
	e2:SetOperation(c21947653.operation)
	c:RegisterEffect(e2)
end
c21947653.material_setcode=0x8
c21947653.dark_calling=true
function c21947653.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c21947653.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
