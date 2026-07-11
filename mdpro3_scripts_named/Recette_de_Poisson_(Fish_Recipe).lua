--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Recette de Poisson (Fish Recipe)  (ID: 87778106)
-- Type: Spell / Ritual
-- Setcode: 0x197
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon any "Nouvelles" Ritual Monster.
-- You must also Tribute monsters from your hand or field whose total Levels equal or exceed the Level
-- of the Ritual Monster you Ritual Summon.
-- Then, if you Ritual Summoned "Buerillabaisse de Nouvelles", you can apply the following effect.
-- ● Add 1 "Recipe" Ritual Spell from your Deck or GY to your hand, except "Recette de Poisson (Fish
-- Recipe)".
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
