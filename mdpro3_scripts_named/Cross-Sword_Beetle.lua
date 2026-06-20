--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 十字剑猎手  (ID: 74976215)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 4
-- ATK 1800 | DEF 1200
--
-- Effect Text:
-- 自己场上有这张卡以外的昆虫族怪兽存在的场合，自己场上存在的昆虫族怪兽攻击守备表示怪兽时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--クロスソード・ハンター
function c74976215.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c74976215.condition)
	e1:SetTarget(c74976215.target)
	c:RegisterEffect(e1)
end
function c74976215.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT)
end
function c74976215.condition(e)
	return Duel.IsExistingMatchingCard(c74976215.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c74976215.target(e,c)
	return c:IsRace(RACE_INSECT)
end
