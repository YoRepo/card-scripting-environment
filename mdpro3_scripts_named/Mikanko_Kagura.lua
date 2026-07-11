--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Mikanko Kagura  (ID: 16310544)
-- Type: Spell / Ritual
-- Setcode: 0x18d
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon any "Mikanko" Ritual Monster.
-- You must also Tribute monsters from your hand or field whose total Levels equal or exceed the Level
-- of the Ritual Monster you Ritual Summon.
-- Then you can apply the following effect.
-- ● Destroy cards your opponent controls up to the number of Equip Spells with different names in your
-- GY, and if you do, inflict 1000 damage to your opponent for each card destroyed.
-- You can only activate 1 "Mikanko Kagura" per turn.
--[[ __CARD_HEADER_END__ ]]

--御巫神楽
function c16310544.initial_effect(c)
	local e1=aux.AddRitualProcGreater2(c,c16310544.filter,LOCATION_HAND,nil,nil,true,c16310544.extraop)
	e1:SetCountLimit(1,16310544+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
end
function c16310544.filter(c,e,tp)
	return c:IsSetCard(0x18d)
end
function c16310544.extraop(e,tp,eg,ep,ev,re,r,rp,tc,mat)
	if not tc then return end
	local ct=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_EQUIP):GetClassCount(Card.GetCode)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	if ct>0 and #g>0 and Duel.SelectYesNo(tp,aux.Stringid(16310544,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,ct,nil)
		Duel.HintSelection(sg)
		local res=Duel.Destroy(sg,REASON_EFFECT)
		Duel.Damage(1-tp,res*1000,REASON_EFFECT)
	end
end
