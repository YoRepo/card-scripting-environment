--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 女王的影武者  (ID: 5901497)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 1
-- ATK 350 | DEF 300
--
-- Effect Text:
-- 这张卡可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--女王の影武者
function c5901497.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
