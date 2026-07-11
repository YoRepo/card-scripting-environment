--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Dogmatikamacabre  (ID: 60921537)
-- Type: Spell / Ritual
-- Setcode: 0x145
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon any "Dogmatika" Ritual Monster from your hand or GY.
-- You must also Tribute monsters from your hand or field, and/or banish Fusion or Synchro Monsters
-- from your GY, whose total Levels equal or exceed the Level of the Ritual Monster you Ritual Summon,
-- then, if both "White Knight of Dogmatika" and "White Relic of Dogmatika" are on the field, you can
-- look at either your Extra Deck or your opponent's, and send 1 monster from it to the GY.
-- You can only activate 1 "Dogmatikamacabre" per turn.
--[[ __CARD_HEADER_END__ ]]

--凶導の葬列
function c60921537.initial_effect(c)
	aux.AddCodeList(c,40352445,48654323)
	local e1=aux.AddRitualProcGreater2(c,c60921537.filter,LOCATION_HAND+LOCATION_GRAVE,c60921537.grfilter,nil,true,c60921537.extraop)
	e1:SetCountLimit(1,60921537+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
end
function c60921537.filter(c)
	return c:IsSetCard(0x145)
end
function c60921537.grfilter(c)
	return c:IsType(TYPE_FUSION+TYPE_SYNCHRO)
end
function c60921537.opfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c60921537.extraop(e,tp,eg,ep,ev,re,r,rp,tc)
	if not tc then return end
	local g1=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
	if Duel.IsExistingMatchingCard(c60921537.opfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,40352445)
		and Duel.IsExistingMatchingCard(c60921537.opfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,48654323)
		and (#g1~=0 or #g2~=0) and Duel.SelectYesNo(tp,aux.Stringid(60921537,0)) then
		Duel.BreakEffect()
		local g=nil
		if #g1~=0 and (#g2==0 or Duel.SelectOption(tp,aux.Stringid(60921537,1),aux.Stringid(60921537,2))==0) then
			g=g1
		else
			g=g2
			Duel.ConfirmCards(tp,g,true)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local tg=g:FilterSelect(tp,Card.IsAbleToGrave,1,1,nil)
		Duel.SendtoGrave(tg,REASON_EFFECT)
	end
end
