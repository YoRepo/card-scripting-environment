--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 梦魇马  (ID: 59290628)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 2
-- ATK 500 | DEF 400
--
-- Effect Text:
-- 这张卡在对方场上存在怪兽的状态下也能对对方进行直接攻击。
--[[ __CARD_HEADER_END__ ]]

--ナイトメア・ホース
function c59290628.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
