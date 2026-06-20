--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 混沌形态  (ID: 21082832)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 207
--
-- Effect Text:
-- ①：等级合计直到变成和仪式召唤的怪兽相同为止，把自己的手卡·场上的怪兽解放或者作为解放的代替而从自己墓地把「青眼白龙」或「黑魔术师」除外，从手卡把1只「混沌」仪式怪兽仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--カオス・フォーム
function c21082832.initial_effect(c)
	aux.AddCodeList(c,46986414,89631139)
	aux.AddRitualProcEqual2(c,c21082832.filter,nil,c21082832.mfilter)
end
function c21082832.filter(c,e,tp,m1,m2,ft)
	return c:IsSetCard(0xcf)
end
function c21082832.mfilter(c)
	return c:IsCode(46986414,89631139)
end
