--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: C-Crush Wyvern  (ID: 3405259)
-- Type: Monster / Effect / Union
-- Attribute: LIGHT
-- Race: Machine
-- Level: 4
-- ATK 1200 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can either: Target 1 LIGHT Machine monster you control; equip this card to that
-- target, OR: Unequip this card and Special Summon it.
-- A monster equipped with this card is unaffected by your opponent's Trap effects, also if the
-- equipped monster would be destroyed by battle or card effect, destroy this card instead.
-- If this card is sent from the field to the GY: You can Special Summon 1 Union monster from your
-- hand.
--[[ __CARD_HEADER_END__ ]]

--C－クラッシュ・ワイバーン
function c3405259.initial_effect(c)
	aux.EnableUnionAttribute(c,c3405259.filter)
	--immune
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetValue(c3405259.efilter)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c3405259.spcon2)
	e5:SetTarget(c3405259.sptg2)
	e5:SetOperation(c3405259.spop2)
	c:RegisterEffect(e5)
end
c3405259.has_text_type=TYPE_UNION
function c3405259.filter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c3405259.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:GetOwner()~=e:GetOwner()
		and te:IsActiveType(TYPE_TRAP)
end
function c3405259.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c3405259.spfilter(c,e,tp)
	return c:IsType(TYPE_UNION) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c3405259.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c3405259.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c3405259.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c3405259.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
