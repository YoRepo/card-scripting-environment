--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 蔷薇之魔女  (ID: 23087070)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 4
-- ATK 1600 | DEF 1000
--
-- Effect Text:
-- 植物族怪兽上级召唤的场合，这张卡可以作为2只的数量解放。
--[[ __CARD_HEADER_END__ ]]

--ローズ・ウィッチ
function c23087070.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c23087070.condition)
	c:RegisterEffect(e1)
end
function c23087070.condition(e,c)
	return c:IsRace(RACE_PLANT)
end
