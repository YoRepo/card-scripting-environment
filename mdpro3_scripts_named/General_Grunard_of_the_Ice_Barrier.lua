--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 冰结界的虎将 神兵  (ID: 9056100)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level 8
-- ATK 2800 | DEF 1000
-- Setcode: 47
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，自己在通常召唤外加上只有1次，自己主要阶段可以把1只「冰结界」怪兽召唤。
--[[ __CARD_HEADER_END__ ]]

--氷結界の虎将 グルナード
function c9056100.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9056100,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x2f))
	c:RegisterEffect(e1)
end
