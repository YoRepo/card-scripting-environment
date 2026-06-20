--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 熔岩风神翼龙  (ID: 45439263)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Pyro
-- Level 2
-- ATK 1300 | DEF 700
-- Setcode: 57
--
-- Effect Text:
-- 自己墓地有名字带有「熔岩」的怪兽3种类以上存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ラヴァル・コアトル
function c45439263.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c45439263.spcon)
	c:RegisterEffect(e1)
end
function c45439263.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
	return Duel.GetMatchingGroup(Card.IsSetCard,c:GetControler(),LOCATION_GRAVE,0,nil,0x39):GetClassCount(Card.GetCode)>=3
end
