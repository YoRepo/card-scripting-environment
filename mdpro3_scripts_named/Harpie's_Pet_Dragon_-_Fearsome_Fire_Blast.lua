--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Harpie's Pet Dragon - Fearsome Fire Blast  (ID: 4991081)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level: 7
-- ATK 2000 | DEF 2500
-- Setcode: 0x64
-- Scope: OCG / TCG
--
-- Effect Text:
-- Monsters cannot target Level 6 or lower "Harpie" monsters for attacks.
-- You can only use each of the following effects of "Harpie's Pet Dragon - Fearsome Fire Blast" once
-- per turn.
-- If you control a Level 6 or lower WIND monster: You can Special Summon this card from your hand in
-- Defense Position.
-- If this card is sent from the field to the GY: You can send 1 WIND Winged Beast monster from your
-- Deck to the GY.
--[[ __CARD_HEADER_END__ ]]

--ハーピィズペット竜－セイント・ファイアー・ギガ
function c4991081.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(4991081,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,4991081)
	e1:SetCondition(c4991081.spcon)
	e1:SetTarget(c4991081.sptg)
	e1:SetOperation(c4991081.spop)
	c:RegisterEffect(e1)
	--cannot be target for attacks
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(c4991081.atlimit)
	c:RegisterEffect(e2)
	--burial
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(4991081,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,4991082)
	e3:SetCondition(c4991081.tgcon)
	e3:SetTarget(c4991081.tgtg)
	e3:SetOperation(c4991081.tgop)
	c:RegisterEffect(e3)
end
function c4991081.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND) and c:IsLevelBelow(6)
end
function c4991081.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c4991081.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c4991081.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c4991081.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end
function c4991081.atlimit(e,c)
	return c:IsFaceup() and c:IsLevelBelow(6) and c:IsSetCard(0x64)
end
function c4991081.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c4991081.tgfilter(c)
	return c:IsRace(RACE_WINDBEAST) and c:IsAttribute(ATTRIBUTE_WIND) and c:IsAbleToGrave()
end
function c4991081.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c4991081.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c4991081.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c4991081.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
