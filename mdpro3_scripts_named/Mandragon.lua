--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 曼陀林草龙  (ID: 19474136)
-- Type: Monster / Normal / Pendulum
-- Attribute: EARTH
-- Race: Plant
-- Level 5
-- Pendulum Scales: L2 / R2
-- ATK 2500 | DEF 1000
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- 【怪兽描述】
-- 宿有充满悲哀龙魂的曼陀林。据说会奏起诅咒的音色，使听者过于恐惧而丧失自我。
--[[ __CARD_HEADER_END__ ]]

--マンドラゴン
function c19474136.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
end
