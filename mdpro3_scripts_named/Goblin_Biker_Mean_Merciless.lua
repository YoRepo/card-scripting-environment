--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Goblin Biker Mean Merciless  (ID: 64257161)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fiend
-- Level: 3
-- ATK 1400 | DEF 0
-- Setcode: 0x10ac
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Normal or Special Summoned: You can Special Summon 1 "Goblin" monster from your
-- hand, except "Goblin Biker Mean Merciless".
-- During your Main Phase, if this card is in your GY: You can detach 1 Xyz Material from a monster on
-- either field, and if you do, Special Summon this card, but banish it when it leaves the field.
-- You can only use each effect of "Goblin Biker Mean Merciless" once per turn.
--[[ __CARD_HEADER_END__ ]]

--百鬼羅刹 冷血ミアンダ
function c64257161.initial_effect(c)
	--spcial summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64257161,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,64257161)
	e1:SetTarget(c64257161.sptg)
	e1:SetOperation(c64257161.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--special summon self
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(64257161,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,64257161+1)
	e3:SetTarget(c64257161.sptg2)
	e3:SetOperation(c64257161.spop2)
	c:RegisterEffect(e3)
end
function c64257161.spfilter(c,e,tp)
	return c:IsSetCard(0xac) and not c:IsCode(64257161) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c64257161.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c64257161.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c64257161.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c64257161.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c64257161.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckRemoveOverlayCard(tp,1,1,1,REASON_EFFECT) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c64257161.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.RemoveOverlayCard(tp,1,1,1,1,REASON_EFFECT)~=0 and c:IsRelateToEffect(e) then
		if Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
			e1:SetValue(LOCATION_REMOVED)
			c:RegisterEffect(e1,true)
		end
		Duel.SpecialSummonComplete()
	end
end
