--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 枪头喙嘴龙  (ID: 48940337)
-- Type: Monster / Normal / Pendulum
-- Attribute: WIND
-- Race: Dinosaur
-- Level 6
-- Pendulum Scales: L7 / R7
-- ATK 2500 | DEF 800
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- ①：自己的通常怪兽向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
-- 【怪兽描述】
-- 太古灭绝之下幸存的梦幻翼龙。它的模样进化得更有攻击性，尖喙化成了贯穿一切的长枪。尽管如此主食好像还是吃鱼。
--[[ __CARD_HEADER_END__ ]]

--ランスフォリンクス
function c48940337.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c48940337.target)
	c:RegisterEffect(e2)
end
function c48940337.target(e,c)
	return c:IsType(TYPE_NORMAL)
end
