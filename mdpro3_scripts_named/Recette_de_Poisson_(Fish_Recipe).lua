--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 鱼料理的食谱  (ID: 87778106)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 407
--
-- Effect Text:
-- 「新式魔厨」仪式怪兽的降临必需。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡把1只「新式魔厨」仪式怪兽仪式召唤。这个效果把「新式魔厨的马赛鱼汤布耶尔」仪式召唤的场合，可以再让以下效果适用。
-- ●从自己的卡组·墓地把「鱼料理的食谱」以外的1张「食谱」仪式魔法卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--Recette de Poisson～魚料理のレシピ～
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,26223582)
	local e1=aux.AddRitualProcGreater2(c,s.filter,LOCATION_HAND,nil,nil,true,s.extraop)
	e1:SetCategory(e1:GetCategory()|(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_GRAVE_ACTION))
	c:RegisterEffect(e1)
end
function s.filter(c,e,tp)
	return c:IsSetCard(0x196)
end
function s.thfilter(c)
	return c:IsSetCard(0x197) and c:IsAbleToHand() and not c:IsCode(id) and c:GetType()&0x82==0x82
end
function s.extraop(e,tp,eg,ep,ev,re,r,rp,tc,mat)
	if not tc or not tc:IsCode(26223582) then return end
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,nil)
	if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
