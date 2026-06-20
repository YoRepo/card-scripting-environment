--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 创造共鸣者  (ID: 5780210)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Fiend
-- Level 3
-- ATK 800 | DEF 600
-- Setcode: 87
--
-- Effect Text:
-- ①：自己场上有8星以上的同调怪兽存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--クリエイト・リゾネーター
function c5780210.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c5780210.spcon)
	c:RegisterEffect(e1)
end
function c5780210.cfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(8) and c:IsType(TYPE_SYNCHRO)
end
function c5780210.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c5780210.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
