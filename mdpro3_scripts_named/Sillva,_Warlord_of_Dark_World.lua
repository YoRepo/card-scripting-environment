--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Sillva, Warlord of Dark World  (ID: 32619583)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 5
-- ATK 2300 | DEF 1400
-- Setcode: 0x6
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is discarded to the GY by card effect: Special Summon this card, then, if it was
-- discarded from your hand to your GY by an opponent's card effect, your opponent places exactly 2
-- cards from their hand on the bottom of their Deck, in any order.
--[[ __CARD_HEADER_END__ ]]

--暗黒界の軍神 シルバ
function c32619583.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32619583,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c32619583.spcon)
	e1:SetTarget(c32619583.sptg)
	e1:SetOperation(c32619583.spop)
	c:RegisterEffect(e1)
end
function c32619583.spcon(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(e:GetHandler():GetPreviousControler())
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and bit.band(r,0x4040)==0x4040
end
function c32619583.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c32619583.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)>0
		and rp==1-tp and tp==e:GetLabel() and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>1 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(1-tp,aux.TRUE,tp,0,LOCATION_HAND,2,2,nil)
		aux.PlaceCardsOnDeckBottom(1-tp,g)
	end
end
