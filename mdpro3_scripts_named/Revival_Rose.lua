--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Revival Rose  (ID: 12469386)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level: 4
-- ATK 1300 | DEF 1300
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a face-up Level 5 or higher Plant monster(s) you control is destroyed while this card is in the
-- GY: You can Special Summon this card from the GY.
--[[ __CARD_HEADER_END__ ]]

--返り咲く薔薇の大輪
function c12469386.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12469386,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c12469386.spcon)
	e1:SetTarget(c12469386.sptg)
	e1:SetOperation(c12469386.spop)
	c:RegisterEffect(e1)
end
function c12469386.filter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP)
		and c:GetPreviousLevelOnField()>=5 and bit.band(c:GetPreviousRaceOnField(),RACE_PLANT)~=0
end
function c12469386.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c12469386.filter,1,e:GetHandler(),tp)
end
function c12469386.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c12469386.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
