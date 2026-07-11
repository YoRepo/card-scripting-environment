--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Recette de Viande (Meat Recipe)  (ID: 14166715)
-- Type: Spell / Ritual
-- Setcode: 0x197
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon any "Nouvelles" Ritual Monster.
-- You must also Tribute monsters from your hand or field whose total Levels equal or exceed the Level
-- of the Ritual Monster you Ritual Summon.
-- Then, if you Ritual Summoned "Confiras de Nouvelles", you can apply the following effect.
-- ● Change all Defense Position monsters your opponent currently controls to Attack Position.
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
