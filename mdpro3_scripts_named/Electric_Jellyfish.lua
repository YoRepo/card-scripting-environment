--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Electric Jellyfish  (ID: 95824983)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 4
-- ATK 1400 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can send 1 "Umi" from your hand, Deck, or face-up field to the GY; Special Summon 1 WATER
-- monster from your hand.
-- When your opponent activates a monster effect, or Spell Card or effect, while "Umi" is on the field
-- (Quick Effect): You can negate that effect, then, you can make this card gain 600 ATK/DEF.
-- You can only use each effect of "Electric Jellyfish" once per turn.
--[[ __CARD_HEADER_END__ ]]

--電気海月－フィサリア－
function c95824983.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95824983,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,95824983)
	e1:SetCost(c95824983.spcost)
	e1:SetTarget(c95824983.sptg)
	e1:SetOperation(c95824983.spop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95824983,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1,95824984)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c95824983.discon)
	e2:SetTarget(c95824983.distg)
	e2:SetOperation(c95824983.disop)
	c:RegisterEffect(e2)
end
function c95824983.cfilter(c)
	return c:IsCode(22702055) and c:IsAbleToGraveAsCost() and (not c:IsOnField() or c:IsFaceup())
end
function c95824983.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c95824983.cfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c95824983.cfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c95824983.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c95824983.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c95824983.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c95824983.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c95824983.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c95824983.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(22702055)
		and ep==1-tp and re:IsActiveType(TYPE_SPELL+TYPE_MONSTER) and Duel.IsChainDisablable(ev)
end
function c95824983.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c95824983.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.NegateEffect(ev) and c:IsRelateToEffect(e) and c:IsFaceup()
		and Duel.SelectYesNo(tp,aux.Stringid(95824983,2)) then
		Duel.BreakEffect()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(600)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
end
