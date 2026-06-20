--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 狮头短吻鳄  (ID: 4611269)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level 4
-- ATK 1900 | DEF 200
--
-- Effect Text:
-- 自己场上有这张卡以外的爬虫类族怪兽存在的场合，自己场上存在的爬虫类族怪兽向守备表示怪兽攻击时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--ライオ・アリゲーター
function c4611269.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c4611269.condition)
	e1:SetTarget(c4611269.target)
	c:RegisterEffect(e1)
end
function c4611269.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_REPTILE)
end
function c4611269.condition(e)
	return Duel.IsExistingMatchingCard(c4611269.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c4611269.target(e,c)
	return c:IsRace(RACE_REPTILE)
end
