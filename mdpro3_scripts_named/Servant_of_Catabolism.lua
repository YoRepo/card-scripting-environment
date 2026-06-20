--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 异形的从者  (ID: 2792265)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Aqua
-- Level 3
-- ATK 700 | DEF 500
--
-- Effect Text:
-- 这张卡可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--異形の従者
function c2792265.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
