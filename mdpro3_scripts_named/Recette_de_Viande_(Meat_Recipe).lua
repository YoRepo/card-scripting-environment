--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 肉料理的食谱  (ID: 14166715)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 407
--
-- Effect Text:
-- 「新式魔厨」仪式怪兽的降临必需。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡把1只「新式魔厨」仪式怪兽仪式召唤。这个效果把「新式魔厨的油封佛拉斯」仪式召唤的场合，可以再让以下效果适用。
-- ●对方场上的守备表示怪兽全部变成表侧攻击表示。
--[[ __CARD_HEADER_END__ ]]

--Recette de Viande～肉料理のレシピ～
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,53618197)
	aux.AddRitualProcGreater2(c,s.filter,LOCATION_HAND,nil,nil,false,s.extraop)
end
function s.filter(c,e,tp)
	return c:IsSetCard(0x196)
end
function s.extraop(e,tp,eg,ep,ev,re,r,rp,tc,mat)
	if not tc or not tc:IsCode(53618197) then return end
	local g=Duel.GetMatchingGroup(Card.IsDefensePos,tp,0,LOCATION_MZONE,nil)
	if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.BreakEffect()
		Duel.ChangePosition(g,POS_FACEUP_ATTACK)
	end
end
