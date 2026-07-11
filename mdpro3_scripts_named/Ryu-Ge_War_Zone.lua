--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Ryu-Ge War Zone  (ID: 55276522)
-- Type: Spell / Field
-- Setcode: 0x1c0
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is activated: Take 1 Dinosaur, 1 Sea Serpent, and 1 Wyrm monster from your Deck, add
-- 1 to your hand, banish 1, and send 1 to the GY, also you cannot Special Summon for the rest of this
-- turn, except Dragon, Dinosaur, Sea Serpent, or Wyrm monsters.
-- If you have "Sosei Ryu-Ge Mistva" in your Extra Deck face-up: You can Special Summon 3 "Ryu-Ge"
-- monsters with different Types, 1 each from your Deck, GY, and banishment.
-- You can only use each effect of "Ryu-Ge War Zone" once per turn.
--[[ __CARD_HEADER_END__ ]]

--登竜華転生紋
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,92487128)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_REMOVE+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
function s.hgrfilter(c)
	return c:IsRace(RACE_DINOSAUR+RACE_SEASERPENT+RACE_WYRM)
		and (c:IsAbleToHand() or c:IsAbleToGrave() or c:IsAbleToRemove())
end
function s.gcheck(g,tp)
	return g:FilterCount(Card.IsRace,nil,RACE_DINOSAUR)==1
		and g:FilterCount(Card.IsRace,nil,RACE_SEASERPENT)==1
		and g:FilterCount(Card.IsRace,nil,RACE_WYRM)==1
		and g:IsExists(s.thfiter,1,nil,g)
end
function s.thfiter(c,g)
	return c:IsAbleToHand() and g:IsExists(s.rmfiter,1,c,g,c)
end
function s.rmfiter(c,g,tc)
	return c:IsAbleToRemove() and g:IsExists(s.tgfiter,1,Group.FromCards(c,tc))
end
function s.tgfiter(c)
	return c:IsAbleToGrave()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(s.hgrfilter,tp,LOCATION_DECK,0,nil)
	if chk==0 then return g:CheckSubGroup(s.gcheck,3,3,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.hgrfilter,tp,LOCATION_DECK,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,2))
	local sg=g:SelectSubGroup(tp,s.gcheck,false,3,3,tp)
	if sg and sg:GetCount()>2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=sg:FilterSelect(tp,s.thfiter,1,1,nil,sg)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g2=sg:FilterSelect(tp,s.rmfiter,1,1,g1,sg,g1:GetFirst())
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g3=sg:FilterSelect(tp,s.tgfiter,1,1,g1+g2)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
		Duel.Remove(g2,POS_FACEUP,REASON_EFFECT)
		Duel.SendtoGrave(g3,REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(s.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function s.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsRace(RACE_DRAGON+RACE_DINOSAUR+RACE_SEASERPENT+RACE_WYRM)
end
function s.cfilter(c,e,tp)
	return c:IsCode(92487128) and c:IsFaceup()
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_EXTRA,0,1,nil)
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x1c0) and c:IsFaceupEx()
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.spgcheck(g,tp)
	return g:FilterCount(Card.IsLocation,nil,LOCATION_DECK)==1
		and g:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)==1
		and g:FilterCount(Card.IsLocation,nil,LOCATION_REMOVED)==1
		and g:GetClassCount(Card.GetRace)==#g
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,nil,e,tp)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and g:CheckSubGroup(s.spgcheck,3,3,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=2 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.spfilter),tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,nil,e,tp)
	if g:CheckSubGroup(s.spgcheck,3,3,tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:SelectSubGroup(tp,s.spgcheck,false,3,3,tp)
		if sg:GetCount()>2 then
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
