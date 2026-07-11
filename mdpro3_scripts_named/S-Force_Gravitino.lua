--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: S-Force Gravitino  (ID: 21368442)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Psychic
-- Level: 5
-- ATK 2000 | DEF 1400
-- Setcode: 0x156
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each of your opponent's monsters in the same column as one of your "S-Force" monsters is banished
-- when it leaves the field.
-- If this card is Normal or Special Summoned: You can add 1 "S-Force" card from your Deck to your
-- hand, except "S-Force Gravitino".
-- You can only use this effect of "S-Force Gravitino" once per turn.
--[[ __CARD_HEADER_END__ ]]

--S－Force グラビティーノ
function c21368442.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21368442,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,21368442)
	e1:SetTarget(c21368442.thtg)
	e1:SetOperation(c21368442.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--redirect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c21368442.rmtg)
	e3:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e3)
end
function c21368442.thfilter(c)
	return c:IsSetCard(0x156) and not c:IsCode(21368442) and c:IsAbleToHand()
end
function c21368442.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21368442.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c21368442.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c21368442.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c21368442.rmfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x156) and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function c21368442.rmtg(e,c)
	local cg=c:GetColumnGroup()
	return cg:IsExists(c21368442.rmfilter,1,nil,e:GetHandlerPlayer())
end
