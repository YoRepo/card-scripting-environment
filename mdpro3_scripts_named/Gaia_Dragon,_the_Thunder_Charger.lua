--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 迅雷之骑士 盖亚龙骑士  (ID: 91949988)
-- Type: Monster / Effect / Xyz
-- Attribute: WIND
-- Race: Dragon
-- Rank 7
-- ATK 2600 | DEF 2100
--
-- Effect Text:
-- 7星怪兽×2
-- 这张卡也能在自己场上的5·6阶的超量怪兽上面重叠来超量召唤。
-- ①：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--迅雷の騎士ガイアドラグーン
function c91949988.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,2,c91949988.ovfilter,aux.Stringid(91949988,0))
	c:EnableReviveLimit()
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
function c91949988.ovfilter(c)
	return c:IsFaceup() and c:IsRank(5,6)
end
