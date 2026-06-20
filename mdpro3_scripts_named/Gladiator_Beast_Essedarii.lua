--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 剑斗兽 车斗  (ID: 73285669)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Beast
-- Level 5
-- ATK 2500 | DEF 1400
-- Setcode: 4121
--
-- Effect Text:
-- 名字带有「剑斗兽」的怪兽×2
-- 让自己场上的上记的卡回到卡组的场合才能从额外卡组特殊召唤（不需要「融合」）。
--[[ __CARD_HEADER_END__ ]]

--剣闘獣エセダリ
function c73285669.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1019),2,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToDeckOrExtraAsCost,LOCATION_MZONE,0,aux.ContactFusionSendToDeck(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c73285669.splimit)
	c:RegisterEffect(e1)
end
function c73285669.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
