--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 人造人7号  (ID: 32809211)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 2
-- ATK 500 | DEF 400
-- Setcode: 188
--
-- Effect Text:
-- 这张卡可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--人造人間7号
function c32809211.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
