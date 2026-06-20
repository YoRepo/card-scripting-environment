--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 原始电子龙  (ID: 26439287)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 3
-- ATK 1100 | DEF 600
-- Setcode: 4243
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，卡名当作「电子龙」使用。
--[[ __CARD_HEADER_END__ ]]

--プロト・サイバー・ドラゴン
function c26439287.initial_effect(c)
	--code
	aux.EnableChangeCode(c,70095154)
end
