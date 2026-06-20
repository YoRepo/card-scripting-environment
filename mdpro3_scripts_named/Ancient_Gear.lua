--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 古代的齿车  (ID: 31557782)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 2
-- ATK 100 | DEF 800
-- Setcode: 7
--
-- Effect Text:
-- 自己场上有「古代的齿车」表侧表示存在时，这张卡可以从手卡以攻击表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--古代の歯車
function c31557782.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c31557782.spcon)
	c:RegisterEffect(e1)
end
function c31557782.filter(c)
	return c:IsFaceup() and c:IsCode(31557782)
end
function c31557782.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c31557782.filter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
