--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 我我我书记  (ID: 44250812)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 2
-- ATK 400 | DEF 800
-- Setcode: 84
--
-- Effect Text:
-- ①：自己场上有「我我我书记」以外的「我我我」怪兽存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ガガガクラーク
function c44250812.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c44250812.spcon)
	c:RegisterEffect(e1)
end
function c44250812.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x54) and not c:IsCode(44250812)
end
function c44250812.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c44250812.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
