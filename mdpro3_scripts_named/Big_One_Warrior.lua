--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Big One Warrior  (ID: 89235196)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 1
-- ATK 100 | DEF 600
-- Setcode: 0x66
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Main Phase, you can send 1 Level 1 monster, except this card, from your hand to the
-- Graveyard to Special Summon this card from your hand.
--[[ __CARD_HEADER_END__ ]]

--ビッグ・ワン・ウォリアー
function c89235196.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89235196,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c89235196.spcost)
	e1:SetTarget(c89235196.sptg)
	e1:SetOperation(c89235196.spop)
	c:RegisterEffect(e1)
end
function c89235196.cfilter(c)
	return c:IsLevel(1) and c:IsAbleToGraveAsCost()
end
function c89235196.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c89235196.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c89235196.cfilter,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c89235196.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c89235196.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
