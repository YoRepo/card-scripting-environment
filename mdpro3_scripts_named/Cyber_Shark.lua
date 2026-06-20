--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 电子鲨  (ID: 32393580)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 5
-- ATK 2100 | DEF 2000
-- Setcode: 28835987
--
-- Effect Text:
-- 自己场上有水属性怪兽表侧表示存在的场合，这张卡可以不用解放作召唤。
--[[ __CARD_HEADER_END__ ]]

--サイバー・シャーク
function c32393580.initial_effect(c)
	--summon without tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32393580,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c32393580.ntcon)
	c:RegisterEffect(e1)
end
function c32393580.ntfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c32393580.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c32393580.ntfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
