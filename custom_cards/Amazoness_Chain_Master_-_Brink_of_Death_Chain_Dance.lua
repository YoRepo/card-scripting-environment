--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-10-16T00:00:00
-- Card: Amazoness Chain Master - Brink of Death Chain Dance  (ID: 101403005)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 1300
-- Setcode: 0x4 (Amazoness)
--
-- Effect Text:
-- You can only use the effect of this card's name once per turn.
-- ① If this card is sent to the GY and you have another "Amazoness" monster there: You can pay 1000
-- LP; your opponent can choose 1 Level 10 monster in their Deck or Extra Deck, and if they do, you can
-- Special Summon it to your field, ignoring its Summoning conditions, but it cannot activate its
-- effects this turn. If they do not, you discard 1 random card from their hand.
--[[ __CARD_HEADER_END__ ]]

--Amazoness Chain Master - Brink of Death Chain Dance
local s,id,o=GetID()
function s.initial_effect(c)
	--(1) if sent to the GY while you have another "Amazoness" monster there: pay 1000 LP; your opponent can choose
	--1 Level 10 monster in their Deck/Extra Deck for you to Special Summon, otherwise discard 1 random card from their hand
	--(DAMAGE_STEP: it can be sent there by battle, cf. Fiendish Vortex of Atlantis "If this card is sent to the GY and ...")
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_HANDES_OPPO)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.condition)
	e1:SetCost(s.cost)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end
--(1)
--another "Amazoness" monster in your GY (the GY also holds Spells/Traps), this card excepted (cf. Aqua Armor Ninja)
function s.cfilter(c)
	return c:IsSetCard(0x4) and c:IsType(TYPE_MONSTER)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler())
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
--the opponent can always decline, so the "If they do not" discard must be possible (cf. Pair Bear Scare!!,
--and the original Amazoness Chain Master's hand check); their Deck/Extra Deck is not looked at here
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	--player tp = the summoner, from the opponent's Deck/Extra Deck (cf. Mimighoul Charm)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_HANDES_OPPO,nil,0,1-tp,1)
end
--what the opponent may choose: any Level 10 monster (Xyz/Link have no Level). Not filtered by whether you can
--Special Summon it: choosing is their whole action, the summon is a separate step (cf. Mimighoul Charm, Lullaby of Obedience)
function s.lvfilter(c)
	return c:IsLevel(10) and c:IsType(TYPE_MONSTER)
end
--you can Special Summon it ignoring its Summoning conditions, with the zone check per location
--(cf. Spiritual Beast Tamer Winda "from your Deck or Extra Deck, ignoring its Summoning conditions")
function s.spcheck(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,true,false)
		and (c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
			or not c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	--"your opponent can choose": asked only if they have a Level 10 monster there (cf. Pair Bear Scare!!)
	if Duel.IsExistingMatchingCard(s.lvfilter,tp,0,LOCATION_DECK+LOCATION_EXTRA,1,nil)
		and Duel.SelectYesNo(1-tp,aux.Stringid(id,1)) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CONFIRM)
		local tc=Duel.SelectMatchingCard(1-tp,s.lvfilter,1-tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil):GetFirst()
		Duel.ConfirmCards(tp,tc)
		local fromdeck=tc:IsLocation(LOCATION_DECK)
		--"and if they do, you can Special Summon it": your choice, only if it can be summoned (cf. Hecahands Xeno)
		if s.spcheck(tc,e,tp) and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
			--"cannot activate its effects this turn" (cf. Gluttonous Reptolphin Greethys)
			if Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP) then
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_CANNOT_TRIGGER)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
				tc:RegisterEffect(e1)
			end
			Duel.SpecialSummonComplete()
		end
		--the choice was made in a hidden zone: shuffle it (cf. Lullaby of Obedience / Galaxy Hundred)
		if fromdeck then
			Duel.ShuffleDeck(1-tp)
		else
			Duel.ShuffleExtra(1-tp)
		end
		--they chose: no discard, even if you did not or could not Special Summon it
		return
	end
	--"If they do not, you discard 1 random card from their hand" (cf. Saffira, Divine Dragon of the Voiceless Voice)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if #g==0 then return end
	local sg=g:RandomSelect(tp,1)
	Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
end
