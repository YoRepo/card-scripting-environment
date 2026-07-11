--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Reptilianne Coatl  (ID: 89594399)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Reptile
-- Level: 4
-- ATK 1400 | DEF 1000
-- Setcode: 0x3c
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a DARK Reptile monster: You can Special Summon this card from your hand, then, if
-- your opponent controls any monsters with 0 ATK, you can Special Summon up to an equal number of
-- "Reptilianne" monsters from your hand.
-- You can only use this effect of "Reptilianne Coatl" once per turn.
-- If this card you control would be used as Synchro Material for a Reptile monster, you can treat it
-- as a non-Tuner.
--[[ __CARD_HEADER_END__ ]]

--レプティレス・コアトル
function c89594399.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,89594399)
	e1:SetCondition(c89594399.spcon)
	e1:SetTarget(c89594399.sptg)
	e1:SetOperation(c89594399.spop)
	c:RegisterEffect(e1)
	--nontuner
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_NONTUNER)
	e2:SetValue(c89594399.ntval)
	c:RegisterEffect(e2)
end
function c89594399.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_REPTILE) and c:IsAttribute(ATTRIBUTE_DARK)
end
function c89594399.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c89594399.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c89594399.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c89594399.cgfilter(c)
	return c:IsFaceup() and c:IsAttack(0)
end
function c89594399.spfilter(c,e,tp)
	return c:IsSetCard(0x3c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c89594399.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local cg=Duel.GetMatchingGroup(c89594399.cgfilter,tp,0,LOCATION_MZONE,nil)
		local ct=math.min(#cg,(Duel.GetLocationCount(tp,LOCATION_MZONE)))
		if ct>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ct=1 end
		local g=Duel.GetMatchingGroup(c89594399.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
		if g:GetCount()>0 and ct>0 and Duel.SelectYesNo(tp,aux.Stringid(89594399,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:Select(tp,1,ct,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c89594399.ntval(e,c)
	return e:GetHandler():IsControler(c:GetControler()) and c:IsRace(RACE_REPTILE)
end
