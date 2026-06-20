--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 人鱼骑士  (ID: 24435369)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 4
-- ATK 1500 | DEF 700
--
-- Effect Text:
-- ①：只要场上有「海」存在，这张卡在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--マーメイド・ナイト
function c24435369.initial_effect(c)
	aux.AddCodeList(c,22702055)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetCondition(c24435369.dircon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c24435369.dircon(e)
	return Duel.IsEnvironment(22702055)
end
