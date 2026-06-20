--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 魔法灯  (ID: 98049915)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 1
-- ATK 400 | DEF 300
--
-- Effect Text:
-- 这张卡可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--魔法のランプ
function c98049915.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
