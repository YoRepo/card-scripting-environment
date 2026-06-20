--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 人形鳞虫  (ID: 5600127)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Aqua
-- Level 7
-- ATK 2200 | DEF 2000
--
-- Effect Text:
-- 「鳞虫」＋「人形史莱姆」
--[[ __CARD_HEADER_END__ ]]

--ヒューマノイド・ドレイク
function c5600127.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,73216412,46821314,true,true)
end
