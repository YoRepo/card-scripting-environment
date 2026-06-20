--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 领头蝴蝶  (ID: 71353388)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 1
-- ATK 300 | DEF 600
--
-- Effect Text:
-- 对方场上有同调怪兽表侧表示存在，自己场上没有同调怪兽表侧表示存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--リード・バタフライ
function c71353388.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c71353388.spcon)
	c:RegisterEffect(e1)
end
function c71353388.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c71353388.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c71353388.cfilter,c:GetControler(),0,LOCATION_MZONE,1,nil)
		and	not Duel.IsExistingMatchingCard(c71353388.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
