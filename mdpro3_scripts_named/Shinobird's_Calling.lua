--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 灵魂的降神  (ID: 73055622)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「灵魂鸟神-姬孔雀」「灵魂鸟神-彦孔雀」的降临必需。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放或者作为解放的代替而把自己墓地的灵魂怪兽除外，从手卡把「灵魂鸟神-姬孔雀」或者「灵魂鸟神-彦孔雀」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--霊魂の降神
function c73055622.initial_effect(c)
	aux.AddRitualProcGreater2Code2(c,25415052,52900000,nil,c73055622.mfilter)
end
c73055622.has_text_type=TYPE_SPIRIT
function c73055622.mfilter(c)
	return c:IsType(TYPE_SPIRIT)
end
