--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 宣告者的神托  (ID: 79306385)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「崇光之宣告者」的降临必需。对方不能对应这张卡的发动把魔法·陷阱·怪兽的效果发动。
-- ①：从自己的手卡·场上把等级合计直到12以上的怪兽解放，从手卡把「崇光之宣告者」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--宣告者の神託
function c79306385.initial_effect(c)
	--Activate
	aux.AddRitualProcGreaterCode(c,48546368,nil,nil,nil,false,nil,c79306385.extratg)
end
function c79306385.extratg(e,tp,eg,ep,ev,re,r,rp)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.SetChainLimit(c79306385.chlimit)
	end
end
function c79306385.chlimit(e,ep,tp)
	return tp==ep
end
