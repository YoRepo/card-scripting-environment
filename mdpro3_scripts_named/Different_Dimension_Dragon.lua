--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 异次元龙  (ID: 50939127)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 5
-- ATK 1200 | DEF 1500
--
-- Effect Text:
-- 这张卡不会被不指定对象的魔法、陷阱卡的效果破坏。这张卡不会被攻击力1900以下的怪兽战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--異次元竜 トワイライトゾーンドラゴン
function c50939127.initial_effect(c)
	--indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetValue(c50939127.ind1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c50939127.ind2)
	c:RegisterEffect(e2)
end
function c50939127.ind1(e,re,rp,c)
	return not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c50939127.ind2(e,c)
	return c:IsAttackBelow(1900)
end
