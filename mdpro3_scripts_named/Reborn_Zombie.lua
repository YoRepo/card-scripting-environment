--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 再生僵尸  (ID: 23421244)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 4
-- ATK 1000 | DEF 1600
--
-- Effect Text:
-- 只要自己手卡是0张，场上攻击表示存在的这张卡不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--リボーン・ゾンビ
function c23421244.initial_effect(c)
	--cannot destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c23421244.condition)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c23421244.condition(e)
	return e:GetHandler():IsAttackPos() and Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)==0
end
