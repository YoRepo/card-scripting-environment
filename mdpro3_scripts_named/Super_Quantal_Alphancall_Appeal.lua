--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Super Quantal Alphancall Appeal  (ID: 15721392)
-- Type: Spell / Quick-Play
-- Setcode: 0xdc
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a "Super Quant" monster you control is destroyed by battle: Special Summon 1 "Super Quantal Mech
-- Beast" Xyz Monster from your Extra Deck, then you can Special Summon 1 "Super Quantum" monster from
-- your hand, Deck, or GY, that is mentioned on that Xyz Monster, but negate its effects.
-- You can only activate 1 "Super Quantal Alphancall Appeal" per turn.
--[[ __CARD_HEADER_END__ ]]

--超量要請アルファンコール
function c15721392.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCountLimit(1,15721392+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c15721392.condition)
	e1:SetTarget(c15721392.target)
	e1:SetOperation(c15721392.activate)
	c:RegisterEffect(e1)
end
function c15721392.cfilter(c,tp)
	return c:IsSetCard(0xdc) and c:IsPreviousControler(tp)
end
function c15721392.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c15721392.cfilter,1,nil,tp)
end
function c15721392.spfilter(c,e,tp)
	return c:IsSetCard(0x20dc) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c15721392.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c15721392.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c15721392.spfilter2(c,e,tp,mc)
	return c:IsSetCard(0x10dc) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and aux.IsCodeListed(mc,c:GetCode())
end
function c15721392.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c15721392.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=g:Select(tp,1,1,nil):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		local g2=Duel.GetMatchingGroup(aux.NecroValleyFilter(c15721392.spfilter2),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,nil,e,tp,tc)
		if #g2<=0 or not Duel.SelectYesNo(tp,aux.Stringid(15721392,0)) then return end
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc2=g2:Select(tp,1,1,nil):GetFirst()
		if tc2 and Duel.SpecialSummonStep(tc2,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc2:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetValue(RESET_TURN_SET)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc2:RegisterEffect(e2)
		end
		Duel.SpecialSummonComplete()
	end
end
