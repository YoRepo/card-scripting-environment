--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Battlin' Boxing Cross Counter  (ID: 19688343)
-- Type: Trap / Counter
-- Setcode: 0x2084, 0x199
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent activates a monster effect: Destroy 1 "Battlin' Boxer" or "Number" Xyz Monster
-- you control, and if you do, negate the activation, and if you do that, destroy that monster, then
-- you can apply the following effect.
-- ● Special Summon 1 "Battlin' Boxer" Xyz Monster from your Extra Deck with a different name than the
-- first monster, and if you do, attach this card to it as material.
-- You can only activate 1 "Battlin' Boxing Cross Counter" per turn.
--[[ __CARD_HEADER_END__ ]]

--バーニングナックル・クロスカウンター
function c19688343.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,19688343+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c19688343.condition)
	e1:SetTarget(c19688343.target)
	e1:SetOperation(c19688343.activate)
	c:RegisterEffect(e1)
end
function c19688343.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c19688343.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x48,0x1084) and c:IsType(TYPE_XYZ)
end
function c19688343.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c19688343.desfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	local g=Duel.GetMatchingGroup(c19688343.desfilter,tp,LOCATION_MZONE,0,nil)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		g:Merge(eg)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c19688343.spfilter(c,e,tp,code)
	return c:IsSetCard(0x1084) and c:IsType(TYPE_XYZ) and not c:IsCode(code)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c19688343.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectMatchingCard(tp,c19688343.desfilter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=dg:GetFirst()
	if tc then
		Duel.HintSelection(dg)
		if Duel.Destroy(tc,REASON_EFFECT)~=0 and Duel.NegateActivation(ev)
			and re:GetHandler():IsRelateToEffect(re) and Duel.Destroy(eg,REASON_EFFECT)~=0 then
			local c=e:GetHandler()
			local g=Duel.GetMatchingGroup(c19688343.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp,tc:GetCode())
			if g:GetCount()>0 and c:IsRelateToChain() and c:IsCanOverlay()
				and Duel.SelectYesNo(tp,aux.Stringid(19688343,0)) then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local sc=g:Select(tp,1,1,nil):GetFirst()
				if Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)~=0 then
					c:CancelToGrave()
					Duel.Overlay(sc,c)
				end
			end
		end
	end
end
