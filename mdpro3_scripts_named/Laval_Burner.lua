--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 熔岩焚烧者  (ID: 88958576)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 5
-- ATK 2100 | DEF 1000
-- Setcode: 57
--
-- Effect Text:
-- 自己墓地有名字带有「熔岩」的怪兽3种类以上存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ラヴァルバーナー
function c88958576.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c88958576.spcon)
	c:RegisterEffect(e1)
end
function c88958576.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(Card.IsSetCard,c:GetControler(),LOCATION_GRAVE,0,nil,0x39)
	local ct=g:GetClassCount(Card.GetCode)
	return ct>=3
end
