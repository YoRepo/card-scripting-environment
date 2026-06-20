--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 备份秘书  (ID: 63528891)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level 3
-- ATK 1200 | DEF 800
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：自己场上有电子界族怪兽存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--バックアップ・セクレタリー
function c63528891.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63528891,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,63528891+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c63528891.spcon)
	c:RegisterEffect(e1)
end
function c63528891.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_CYBERSE)
end
function c63528891.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c63528891.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
