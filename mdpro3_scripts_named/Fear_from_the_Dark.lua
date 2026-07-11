--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Fear from the Dark  (ID: 34193084)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level: 4
-- ATK 1700 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is sent from your hand or Deck to your Graveyard by an opponent's card effect:
-- Special Summon this card.
--[[ __CARD_HEADER_END__ ]]

--闇よりの恐怖
function c34193084.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34193084,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c34193084.spcon)
	e1:SetTarget(c34193084.sptg)
	e1:SetOperation(c34193084.spop)
	c:RegisterEffect(e1)
end
function c34193084.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND+LOCATION_DECK) and bit.band(r,REASON_EFFECT)~=0 and rp==1-tp
end
function c34193084.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c34193084.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
