--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: The Fang of Critias  (ID: 11082056)
-- Type: Spell
-- Setcode: 0xa1
-- Scope: OCG / TCG
--
-- Effect Text:
-- (This card is also always treated as "Legendary Dragon Critias".)
-- Send 1 Trap from your hand or field to the GY, that is listed on a Fusion Monster that can only be
-- Special Summoned with "The Fang of Critias" (if that card is Set, reveal it), then Special Summon
-- that Fusion Monster from your Extra Deck.
-- You can only activate 1 "The Fang of Critias" per turn.
--[[ __CARD_HEADER_END__ ]]

--クリティウスの牙
function c11082056.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,11082056+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c11082056.target)
	e1:SetOperation(c11082056.activate)
	c:RegisterEffect(e1)
	--add code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ADD_CODE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(10000060)
	c:RegisterEffect(e2)
end
function c11082056.tgfilter(c,e,tp)
	return c:IsType(TYPE_TRAP) and Duel.IsExistingMatchingCard(c11082056.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetCode(),c)
end
function c11082056.spfilter(c,e,tp,code,tc)
	return c:IsType(TYPE_FUSION) and c.material_trap and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and code==c.material_trap
		and Duel.GetLocationCountFromEx(tp,tp,tc,c)>0
end
function c11082056.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11082056.tgfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c11082056.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c11082056.tgfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and not tc:IsImmuneToEffect(e) then
		if tc:IsOnField() and tc:IsFacedown() then Duel.ConfirmCards(1-tp,tc) end
		local code=tc:GetCode()
		Duel.SendtoGrave(tc,REASON_EFFECT)
		if not tc:IsLocation(LOCATION_GRAVE) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c11082056.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,code,nil)
		local sc=sg:GetFirst()
		if sc then
			Duel.BreakEffect()
			Duel.SpecialSummon(sc,0,tp,tp,true,false,POS_FACEUP)
			sc:CompleteProcedure()
		end
	end
end
