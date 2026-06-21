--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T00:00:00
-- Card: Inverted Palace Crimsonheart  (ID: 211040)
-- Type: Spell / Field
-- Setcode: 0x95c (Crimsonheart)
--
-- Effect Text:
-- You can only use the (3) effect of "Inverted Palace Crimsonheart" once per turn.
-- (1) TODO
-- (2) Once per turn, if you Special Summon a monster(s): Your opponent can Special Summon 1 "Barren
-- Lady Lacrimosaica" from their Deck, and if they do, they discard 1 card.
-- (3) If this card is sent to the GY: You can place this card in your opponent's Field Zone face-up,
-- but banish it when it leaves the field.
--[[ __CARD_HEADER_END__ ]]

--Inverted Palace Crimsonheart
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211000)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--TODO: (1) Add a flavorful, useful field effect that applies while this card is in your Field Zone.
	--      (EFFECT_TYPE_FIELD with SetRange(LOCATION_FZONE) goes here.)
	--(2) if you Special Summon: opponent may SS "Barren Lady Lacrimosaica" from their Deck, then discards 1
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
	--(3) if sent to GY: place this card in opponent's Field Zone face-up; banish it when it leaves the field
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,3))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,id)
	e3:SetTarget(s.pltg)
	e3:SetOperation(s.plop)
	c:RegisterEffect(e3)
end
--(2)
function s.cfilter(c,tp)
	return c:IsSummonPlayer(tp)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp)
end
function s.spfilter(c,e,tp)
	return c:IsCode(211000) and c:IsCanBeSpecialSummoned(e,0,tp,false,true)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,1-tp,LOCATION_DECK,0,1,nil,e,1-tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,1-tp,LOCATION_DECK)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0
		or not Duel.IsExistingMatchingCard(s.spfilter,1-tp,LOCATION_DECK,0,1,nil,e,1-tp) then return end
	if not Duel.SelectYesNo(1-tp,aux.Stringid(id,2)) then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(1-tp,s.spfilter,1-tp,LOCATION_DECK,0,1,1,nil,e,1-tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,1-tp,1-tp,false,true,POS_FACEUP)>0
		and Duel.IsExistingMatchingCard(Card.IsDiscardable,1-tp,LOCATION_HAND,0,1,nil,REASON_DISCARD+REASON_EFFECT) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DISCARD)
		local dg=Duel.SelectMatchingCard(1-tp,Card.IsDiscardable,1-tp,LOCATION_HAND,0,1,1,nil,REASON_DISCARD+REASON_EFFECT)
		if dg:GetCount()>0 then
			Duel.SendtoGrave(dg,REASON_DISCARD+REASON_EFFECT)
		end
	end
end
--(3)
function s.pltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsLocation(LOCATION_GRAVE) and not e:GetHandler():IsForbidden() end
end
function s.plop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsLocation(LOCATION_GRAVE) then return end
	local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
	if fc then
		Duel.SendtoGrave(fc,REASON_RULE)
		Duel.BreakEffect()
	end
	if Duel.MoveToField(c,tp,1-tp,LOCATION_FZONE,POS_FACEUP,true) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1)
	end
end
