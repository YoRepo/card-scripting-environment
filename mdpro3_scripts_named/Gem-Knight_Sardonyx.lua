--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Gem-Knight Sardonyx  (ID: 43114901)
-- Type: Monster / Effect / Gemini
-- Attribute: EARTH
-- Race: Pyro
-- Level: 4
-- ATK 1800 | DEF 900
-- Setcode: 0x1047
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is face-up on the field, you can Normal Summon it to have it become an Effect
-- Monster with this effect.
-- ● When this card destroys an opponent's monster by battle and sends it to the Graveyard: You can add
-- 1 "Gem-Knight" card from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--ジェムナイト・サニクス
function c43114901.initial_effect(c)
	aux.EnableDualAttribute(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43114901,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c43114901.thcon)
	e1:SetTarget(c43114901.thtg)
	e1:SetOperation(c43114901.thop)
	c:RegisterEffect(e1)
end
function c43114901.thcon(e,tp,eg,ep,ev,re,r,rp)
	if not aux.IsDualState(e) then return false end
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:GetReasonCard()==e:GetHandler()
		and tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE)
end
function c43114901.filter(c)
	return c:IsSetCard(0x1047) and c:IsAbleToHand()
end
function c43114901.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c43114901.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c43114901.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c43114901.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
