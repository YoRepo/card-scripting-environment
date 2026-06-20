--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 真红眼转生  (ID: 45410988)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 59
--
-- Effect Text:
-- 「真红王」的降临必需。
-- ①：从自己的手卡·场上把等级合计直到8以上的怪兽解放或者作为解放的代替而把自己墓地的「真红眼」怪兽除外，从手卡把「真红王」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--レッドアイズ・トランスマイグレーション
function c45410988.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,19025379,nil,c45410988.mfilter)
end
function c45410988.mfilter(c)
	return c:IsSetCard(0x3b)
end
