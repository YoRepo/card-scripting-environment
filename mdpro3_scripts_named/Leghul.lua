--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 百足虫  (ID: 12472242)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 1
-- ATK 300 | DEF 350
--
-- Effect Text:
-- 这张卡可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--レッグル
function c12472242.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
