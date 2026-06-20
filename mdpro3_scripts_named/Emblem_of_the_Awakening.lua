--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 觉醒之证  (ID: 9845733)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「觉醒战士 库丘林」的降临必需。必须从手卡·自己场上把等级合计直到4以上的怪兽解放。
--[[ __CARD_HEADER_END__ ]]

--覚醒の証
function c9845733.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,10789972)
end
