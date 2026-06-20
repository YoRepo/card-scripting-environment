--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 圣骑士 高文  (ID: 19680539)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1900 | DEF 500
-- Setcode: 4218
--
-- Effect Text:
-- 自己场上有光属性的通常怪兽存在的场合，这张卡可以从手卡表侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--聖騎士ガウェイン
function c19680539.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c19680539.spcon)
	c:RegisterEffect(e1)
end
function c19680539.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c19680539.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c19680539.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
