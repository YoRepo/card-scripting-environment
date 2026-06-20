--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 迦楼加鲁之尸炼魔  (ID: 32872239)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Fiend
-- Level 6
-- Pendulum Scales: L9 / R9
-- ATK 2000 | DEF 2000
--
-- Effect Text:
-- ←9 【灵摆】 9→
-- 【怪兽描述】
-- 身披摇荡之炎，能变一切他者之貌的鸟魔人。从鸟到人、从人到鸟反复变化的过程中，就这么遗忘了本来的自己。
--[[ __CARD_HEADER_END__ ]]

--ガルガルドの屍煉魔
local s,id,o=GetID()
function s.initial_effect(c)
	aux.EnablePendulumAttribute(c)
end
