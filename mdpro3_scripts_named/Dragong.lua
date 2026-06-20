--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 铜锣龙  (ID: 83980492)
-- Type: Monster / Normal / Pendulum
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- Pendulum Scales: L7 / R7
-- ATK 500 | DEF 2100
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- 【怪兽描述】
-- 驱使最新锐的技术，变得能飞行的战斗用铜锣。不得不对以0.7马赫飞翔于天空的其存在而感到惊愕。
--[[ __CARD_HEADER_END__ ]]

--銅鑼ドラゴン
function c83980492.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
end
