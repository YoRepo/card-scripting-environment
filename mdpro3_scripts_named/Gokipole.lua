--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Gokipole  (ID: 17535764)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level: 3
-- ATK 1000 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is sent to the GY: You can add 1 Level 4 Insect monster from your Deck to your hand,
-- then, if you added a Normal Monster, you can Special Summon it, then you can destroy 1 monster on
-- the field with ATK greater than or equal to that Special Summoned monster's.
-- You can only use this effect of "Gokipole" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ゴキポール
function c17535764.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17535764,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,17535764)
	e1:SetTarget(c17535764.thtg)
	e1:SetOperation(c17535764.tgop)
	c:RegisterEffect(e1)
end
function c17535764.thfilter(c)
	return c:IsLevel(4) and c:IsRace(RACE_INSECT) and c:IsAbleToHand()
end
function c17535764.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17535764.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c17535764.desfilter(c,atk)
	return c:IsFaceup() and c:IsAttackAbove(atk)
end
function c17535764.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=Duel.SelectMatchingCard(tp,c17535764.thfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,tc)
		if tc:IsType(TYPE_NORMAL) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and Duel.SelectYesNo(tp,aux.Stringid(17535764,1)) then
			Duel.BreakEffect()
			if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
				local g=Duel.GetMatchingGroup(c17535764.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tc:GetAttack())
				if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(17535764,2)) then
					Duel.BreakEffect()
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
					local tc2=g:Select(tp,1,1,nil)
					Duel.Destroy(tc2,REASON_EFFECT)
				end
			end
		end
	end
end
