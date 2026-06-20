--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 冰帝家臣 埃舍尔  (ID: 24326617)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 4
-- ATK 800 | DEF 1000
--
-- Effect Text:
-- ①：对方的魔法与陷阱区域有卡2张以上存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--氷帝家臣エッシャー
function c24326617.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c24326617.spcon)
	c:RegisterEffect(e1)
end
function c24326617.filter(c)
	return c:GetSequence()<5
end
function c24326617.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c24326617.filter,tp,0,LOCATION_SZONE,2,nil)
end
