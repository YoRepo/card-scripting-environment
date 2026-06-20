--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 龙骑兵团-窄带军事官  (ID: 88361177)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 5
-- ATK 2100 | DEF 1000
-- Setcode: 41
--
-- Effect Text:
-- 这张卡有名字带有「龙骑兵团」的龙族怪兽装备的场合，这张卡向守备表示怪兽攻击时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－アングス
function c88361177.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetCondition(c88361177.pcon)
	c:RegisterEffect(e1)
end
function c88361177.pfilter(c)
	return c:IsSetCard(0x29) and c:IsRace(RACE_DRAGON) and c:IsFaceup()
end
function c88361177.pcon(e)
	return e:GetHandler():GetEquipGroup():IsExists(c88361177.pfilter,1,nil)
end
