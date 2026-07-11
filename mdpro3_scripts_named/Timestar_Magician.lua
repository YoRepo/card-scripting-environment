--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Timestar Magician  (ID: 47349116)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Spellcaster
-- Rank: 4
-- ATK 2400 | DEF 1200
-- Setcode: 0x98
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 4 "Magician" Pendulum Monsters
-- Must first be Xyz Summoned with the above materials.
-- Once per turn: You can detach 1 material from this card; add to your hand, 1 DARK Spellcaster
-- monster from your Deck, GY, or face-up Extra Deck.
-- Once per turn, if a Pendulum Monster Card(s) in your Monster Zone or Pendulum Zone would be
-- destroyed by battle or card effect, you can send 1 Spellcaster monster from your Deck to the GY
-- instead.
--[[ __CARD_HEADER_END__ ]]

--星刻の魔術師
function c47349116.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,c47349116.matfilter,4,2)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c47349116.splimit)
	c:RegisterEffect(e1)
	--Search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(47349116,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c47349116.thcost)
	e2:SetTarget(c47349116.thtg)
	e2:SetOperation(c47349116.thop)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c47349116.reptg)
	e3:SetValue(c47349116.repval)
	c:RegisterEffect(e3)
end
function c47349116.matfilter(c)
	return c:IsSetCard(0x98) and c:IsXyzType(TYPE_PENDULUM)
end
function c47349116.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or (bit.band(st,SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ and not se)
end
function c47349116.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c47349116.thfilter(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_DARK)
		and (c:IsFaceup() or not c:IsLocation(LOCATION_EXTRA)) and c:IsAbleToHand()
end
function c47349116.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c47349116.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_EXTRA)
end
function c47349116.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c47349116.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.SendtoHand(tc,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,tc)
end
function c47349116.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE+LOCATION_PZONE)
		and c:IsType(TYPE_PENDULUM) and c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c47349116.tgfilter(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsAbleToGrave()
end
function c47349116.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c47349116.repfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c47349116.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(tp,c47349116.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.Hint(HINT_CARD,0,47349116)
		Duel.SendtoGrave(sg,REASON_EFFECT)
		return true
	else return false end
end
function c47349116.repval(e,c)
	return c47349116.repfilter(c,e:GetHandlerPlayer())
end
