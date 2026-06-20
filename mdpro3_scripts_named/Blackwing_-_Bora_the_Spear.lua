--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 黑羽-黑枪之布拉斯特  (ID: 49003716)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 4
-- ATK 1700 | DEF 800
-- Setcode: 51
--
-- Effect Text:
-- ①：自己场上有「黑羽-黑枪之布拉斯特」以外的「黑羽」怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--BF－黒槍のブラスト
function c49003716.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c49003716.spcon)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c49003716.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x33) and not c:IsCode(49003716)
end
function c49003716.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c49003716.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
