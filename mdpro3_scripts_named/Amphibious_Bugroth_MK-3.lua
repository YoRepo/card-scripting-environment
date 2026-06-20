--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 水陆两用战斗艇 Mk-3  (ID: 64342551)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Machine
-- Level 4
-- ATK 1500 | DEF 1300
--
-- Effect Text:
-- 当场上存在「海」时，这张卡可以对对方进行直接攻击。
--[[ __CARD_HEADER_END__ ]]

--水陸両用バグロス Mk－3
function c64342551.initial_effect(c)
	aux.AddCodeList(c,22702055)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c64342551.dircon)
	c:RegisterEffect(e1)
end
function c64342551.dircon(e)
	return Duel.IsEnvironment(22702055)
end
