--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-21T00:00:00
-- Card: Crimsonheart Revelation  (ID: 211180)
-- Type: Spell / Quick-Play
-- Setcode: 0x95c (Crimsonheart)
--
-- Effect Text:
-- You can only use 1 "Crimsonheart Revelation" effect per turn and only once that turn.
-- (1) TODO (to be added later)
-- (2) If "Barren Lady Lacrimosaica" is destroyed by battle, or leaves the field because of your
-- opponent's card while this card is in your GY: You can banish this card and 1 "Crimsonheart Rose
-- Key" from your GY; Special Summon 1 "Crimsonheart Hidden Infant" from your Extra Deck.
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Revelation
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211000,211030,211160)
	--(1) TODO: effect to be added later (placeholder activation so the Quick-Play can be played)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id)
	c:RegisterEffect(e1)
	--(2) from GY: if Lacrimosaica is destroyed by battle / leaves field by opponent; banish this + Rose Key, SS Hidden Infant
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.spcon)
	e2:SetCost(s.spcost)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
--(2)
function s.cfilter(c,tp,rp)
	return c:IsCode(211000) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousPosition(POS_FACEUP)
		and (c:IsReason(REASON_BATTLE) or (rp==1-tp and c:IsReason(REASON_EFFECT)))
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp,rp)
end
function s.rkfilter(c)
	return c:IsCode(211030) and c:IsAbleToRemoveAsCost()
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(s.rkfilter,tp,LOCATION_GRAVE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,s.rkfilter,tp,LOCATION_GRAVE,0,1,1,c)
	g:AddCard(c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function s.spfilter(c,e,tp)
	return c:IsCode(211160) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
