--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 宝石骑士·斜绿  (ID: 3113836)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Fairy
-- Level 5
-- ATK 2300 | DEF 1400
-- Setcode: 4167
--
-- Effect Text:
-- 「宝石骑士」怪兽＋光属性怪兽
-- 这张卡用以上记的卡为融合素材的融合召唤才能从额外卡组特殊召唤。
-- ①：只要这张卡在怪兽区域存在，自己在通常召唤外加上只有1次，自己主要阶段可以把1只怪兽通常召唤。
--[[ __CARD_HEADER_END__ ]]

--ジェムナイト・セラフィ
function c3113836.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1047),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_LIGHT),false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c3113836.splimit)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3113836,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_EXTRA_SET_COUNT)
	c:RegisterEffect(e3)
end
function c3113836.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
