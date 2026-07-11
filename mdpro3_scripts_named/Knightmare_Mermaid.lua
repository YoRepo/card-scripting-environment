--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Knightmare Mermaid  (ID: 3679218)
-- Type: Monster / Effect / Link
-- Attribute: WATER
-- Race: Fiend
-- Link Rating: 1
-- Link Arrows: Bottom
-- ATK 1000
-- Setcode: 0x112
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Knightmare" monster, except "Knightmare Mermaid"
-- If this card is Link Summoned: You can discard 1 card; Special Summon 1 "Knightmare" monster from
-- your Deck, then, if this card was co-linked when this effect was activated, you can draw 1 card.
-- You can only use this effect of "Knightmare Mermaid" once per turn.
-- Monsters on the field lose 1000 ATK/DEF, unless they are co-linked.
--[[ __CARD_HEADER_END__ ]]

--トロイメア・マーメイド
function c3679218.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c3679218.matfilter,1,1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3679218,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,3679218)
	e1:SetCondition(c3679218.spcon)
	e1:SetCost(c3679218.spcost)
	e1:SetTarget(c3679218.sptg)
	e1:SetOperation(c3679218.spop)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c3679218.atktg)
	e2:SetValue(-1000)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c3679218.matfilter(c)
	return c:IsLinkSetCard(0x112) and not c:IsLinkCode(3679218)
end
function c3679218.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c3679218.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c3679218.spfilter(c,e,tp)
	return c:IsSetCard(0x112) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c3679218.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c3679218.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	if e:GetHandler():GetMutualLinkedGroupCount()>0 then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
		e:SetLabel(1)
	else
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetLabel(0)
	end
end
function c3679218.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c3679218.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0
		and e:GetLabel()==1 and Duel.IsPlayerCanDraw(tp,1)
		and Duel.SelectYesNo(tp,aux.Stringid(3679218,1)) then
		Duel.BreakEffect()
		Duel.ShuffleDeck(tp)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c3679218.atktg(e,c)
	return c:GetMutualLinkedGroupCount()==0
end
