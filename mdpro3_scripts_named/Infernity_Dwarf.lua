--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 永火矮人  (ID: 25171661)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 2
-- ATK 800 | DEF 500
-- Setcode: 11
--
-- Effect Text:
-- 自己手卡是0张的场合，只要这张卡在自己场上表侧表示存在，自己场上存在的怪兽攻击守备表示怪兽时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・ドワーフ
function c25171661.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c25171661.condition)
	c:RegisterEffect(e1)
end
function c25171661.condition(e)
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)==0
end
