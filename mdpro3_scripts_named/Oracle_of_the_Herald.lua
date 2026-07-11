--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Oracle of the Herald  (ID: 79306385)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Herald of Ultimateness".
-- You must also Tribute monsters from your hand or field whose total Levels equal 12 or more.
-- Your opponent cannot activate cards or effects in response to this card's activation.
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
