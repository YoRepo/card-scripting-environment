--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Brilliant Rose  (ID: 61011438)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Rock
-- Level: 2
-- ATK 500 | DEF 500
-- Setcode: 0x1047
-- Scope: OCG / TCG
--
-- Effect Text:
-- (This card is always treated as a "Gem-Knight" card.)
-- You can discard 1 "Gem-Knight" or "Melodious" card; Special Summon this card from your hand.
-- You can only use this effect of "Brilliant Rose" once per turn.
-- Once per turn: You can send 1 "Gem-Knight" or "Melodious" monster from your Extra Deck to the GY;
-- until the End Phase, this card's name/Type/Attribute become the same as the original
-- name/Type/Attribute of the monster sent to the GY to activate this effect.
--[[ __CARD_HEADER_END__ ]]

--ブリリアント・ローズ
function c61011438.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,61011438)
	e1:SetCost(c61011438.spcost)
	e1:SetTarget(c61011438.sptg)
	e1:SetOperation(c61011438.spop)
	c:RegisterEffect(e1)
	--copy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c61011438.cpcost)
	e2:SetOperation(c61011438.cpop)
	c:RegisterEffect(e2)
end
function c61011438.cfilter(c)
	return c:IsSetCard(0x1047,0x9b) and c:IsDiscardable()
end
function c61011438.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c61011438.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c61011438.cfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c61011438.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c61011438.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c61011438.cpfilter(c)
	return c:IsSetCard(0x1047,0x9b) and c:IsAbleToGraveAsCost()
end
function c61011438.cpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c61011438.cpfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c61011438.cpfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	local tc=g:GetFirst()
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabelObject(tc)
end
function c61011438.cpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not (c:IsFaceup() and c:IsRelateToEffect(e)) then return end
	local tc=e:GetLabelObject()
	local code=tc:GetOriginalCodeRule()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(code)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CHANGE_RACE)
	e2:SetValue(tc:GetOriginalRace())
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e3:SetValue(tc:GetOriginalAttribute())
	c:RegisterEffect(e3)
end
