--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Glow-Up Bloom  (ID: 92964816)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Zombie
-- Level: 1
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is sent to the GY: You can banish this card from your GY; add 1 Level 5 or higher
-- Zombie monster from your Deck to your hand, or, if "Zombie World" is in a Field Zone, you can
-- Special Summon it from your Deck instead, also, in either case, you cannot Special Summon monsters
-- for the rest of this turn, except Zombie monsters.
-- You can only use this effect of "Glow-Up Bloom" once per turn.
--[[ __CARD_HEADER_END__ ]]

--グローアップ・ブルーム
function c92964816.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetDescription(aux.Stringid(92964816,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,92964816)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c92964816.target)
	e1:SetOperation(c92964816.operation)
	c:RegisterEffect(e1)
end
function c92964816.filter(c,e,tp,chk)
	return c:IsLevelAbove(5) and c:IsRace(RACE_ZOMBIE)
		and (c:IsAbleToHand() or chk and c:IsCanBeSpecialSummoned(e,0,tp,false,false))
end
function c92964816.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local res=Duel.IsEnvironment(4064256,PLAYER_ALL,LOCATION_FZONE) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		return Duel.IsExistingMatchingCard(c92964816.filter,tp,LOCATION_DECK,0,1,nil,e,tp,res)
	end
end
function c92964816.operation(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.IsEnvironment(4064256,PLAYER_ALL,LOCATION_FZONE) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=Duel.SelectMatchingCard(tp,c92964816.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp,res):GetFirst()
	if tc then
		if res and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and (not tc:IsAbleToHand() or Duel.SelectOption(tp,1190,1152)==1) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c92964816.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c92964816.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsRace(RACE_ZOMBIE)
end
