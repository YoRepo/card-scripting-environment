--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 闪光之骑士  (ID: 17390179)
-- Type: Monster / Normal / Pendulum
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- Pendulum Scales: L7 / R7
-- ATK 1800 | DEF 600
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- 【怪兽描述】
-- 由于神之灵摆而掌握到新力量的骑士。现在是该觉醒过来，解放那股力量了！
--[[ __CARD_HEADER_END__ ]]

--閃光の騎士
function c17390179.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
end
