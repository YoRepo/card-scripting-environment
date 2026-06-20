--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 巨口  (ID: 58861941)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 1
-- ATK 300 | DEF 250
--
-- Effect Text:
-- 这张卡可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--ラージマウス
function c58861941.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
