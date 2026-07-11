--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Superheavy Samurai Motorbike  (ID: 83334932)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Machine
-- Level: 2
-- ATK 800 | DEF 1200
-- Setcode: 0x9a
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you have no Spells/Traps in your GY: You can discard this card; add 1 "Superheavy Samurai"
-- monster from your Deck to your hand, except "Superheavy Samurai Motorbike".
-- You can only use this effect of "Superheavy Samurai Motorbike" once per turn.
-- Once per turn: You can target 1 Machine monster you control; increase its Level by 2.
--[[ __CARD_HEADER_END__ ]]

--超重武者バイ－Q
function c83334932.initial_effect(c)
	--search S/T
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83334932,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,83334932)
	e1:SetCondition(c83334932.condition)
	e1:SetCost(c83334932.cost)
	e1:SetTarget(c83334932.target)
	e1:SetOperation(c83334932.operation)
	c:RegisterEffect(e1)
	--level up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(83334932,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c83334932.lvtg)
	e2:SetOperation(c83334932.lvop)
	c:RegisterEffect(e2)
end
function c83334932.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c83334932.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c83334932.filter(c)
	return not c:IsCode(83334932) and c:IsSetCard(0x9a) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c83334932.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c83334932.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c83334932.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.SelectMatchingCard(tp,c83334932.filter,tp,LOCATION_DECK,0,1,1,nil)
	if tg:GetCount()>0 then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
function c83334932.lvfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:GetLevel()>0
end
function c83334932.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c83334932.lvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c83334932.lvfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c83334932.lvfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c83334932.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
