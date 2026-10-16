--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-10-16T00:00:00
-- Card: Harpie Lady - Alluring Dance  (ID: 101403008)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1300 | DEF 1400
-- Setcode: 0x64 (Harpie)
--
-- Effect Text:
-- You can only use the ②nd and ③rd effects of this card's name each once per turn.
-- ① This card's name becomes "Harpie Lady" while in the field or GY.
-- ② During the Main Phase, if this card is in your hand (Quick Effect): You can target 1 EARTH or WIND
-- monster you control; return it to the Deck/Extra Deck, and if you do, Special Summon this card.
-- ③ If this card is Normal or Special Summoned: You can add 1 Spell/Trap from your Deck to your hand
-- that mentions "Harpie Lady".
--[[ __CARD_HEADER_END__ ]]

--Harpie Lady - Alluring Dance
local s,id,o=GetID()
function s.initial_effect(c)
	--(1) name becomes "Harpie Lady" while on the field or in the GY
	--(also registers 76812113 in this card's code list, cf. Harpie Perfumer / Harpie Oracle)
	aux.EnableChangeCode(c,76812113,LOCATION_MZONE+LOCATION_GRAVE)
	--(2) (Quick Effect, hand, Main Phase) target 1 EARTH/WIND monster you control; return it to the Deck/Extra Deck,
	--and if you do, Special Summon this card (cf. Mannadium Riumheart)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	--Main-Phase-only hand Quick Effect timing, cf. Unchained Soul of Sharvara / Vanquish Soul Heavy Borger
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--(3) if Normal or Special Summoned: add 1 Spell/Trap that mentions "Harpie Lady" from your Deck to your hand
	--(both registrations share one count code, cf. Harpie Perfumer / Mannadium Riumheart)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,id+o)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
--(2)
--"During the Main Phase": Main Phase 1 or 2 of either player (cf. Maliss <P> March Hare)
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsMainPhase()
end
--face-up (an Attribute is only known face-up, cf. Harpie Dancer); GetMZoneCount lets the target's own zone be
--reused (cf. Mannadium Riumheart); IsAbleToDeck also covers Extra Deck monsters (cf. Medius the Pure)
function s.tdfilter(c,tp)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_EARTH+ATTRIBUTE_WIND) and c:IsAbleToDeck()
		and Duel.GetMZoneCount(tp,c)>0
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.tdfilter(chkc,tp) end
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingTarget(s.tdfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,s.tdfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	--"and if you do": only if it reached the (owner's) Deck/Extra Deck, so a Token gives no summon
	--(cf. Salamangreat Jack Jaguar); an Extra Deck monster is sent to the Extra Deck by SendtoDeck itself
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)>0
		and tc:IsLocation(LOCATION_DECK+LOCATION_EXTRA) and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
--(3)
--Spell/Trap that mentions "Harpie Lady": new cards register it (aux.AddCodeList); the older ones that name it register only
--"Harpie Lady Sisters" or nothing, so they are listed by code: "Alluring Mirror Split", "Cyber Shield", "Elegant Egotist",
--"Harpie's Feather Rest", "Harpie Lady Phoenix Formation", "Harpies' Hunting Ground", "Hysteric Party"
function s.hlstfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and (aux.IsCodeListed(c,76812113)
		or c:IsCode(92881099,63224564,90219263,39275698,86308219,75782277,77778835))
end
function s.thfilter(c)
	return s.hlstfilter(c) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
