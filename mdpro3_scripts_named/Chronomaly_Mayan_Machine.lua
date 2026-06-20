--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 先史遗产 玛雅机器  (ID: 25163248)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 3
-- ATK 1500 | DEF 700
-- Setcode: 112
--
-- Effect Text:
-- 机械族怪兽上级召唤的场合，这张卡可以作为2只的数量解放。
--[[ __CARD_HEADER_END__ ]]

--先史遺産マヤン・マシーン
function c25163248.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c25163248.condition)
	c:RegisterEffect(e1)
end
function c25163248.condition(e,c)
	return c:IsRace(RACE_MACHINE)
end
