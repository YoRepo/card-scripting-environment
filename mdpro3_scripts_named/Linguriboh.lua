--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Linguriboh  (ID: 24842059)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- Link Rating: 1
-- Link Arrows: Bottom-Left
-- ATK 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Level 4 or lower Cyberse monster
-- When your opponent activates a Trap Card (Quick Effect): You can Tribute this card; negate that
-- card's effect, and if you do, banish it.
-- If this card is in your GY (Quick Effect): You can Tribute 1 "@Ignister" monster that was Special
-- Summoned from the Extra Deck; Special Summon this card.
-- You can only use each effect of "Linguriboh" once per turn.
--[[ __CARD_HEADER_END__ ]]

--リングリボー
function c24842059.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c24842059.mfilter,1,1)
	c:EnableReviveLimit()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24842059,0))
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,24842059)
	e1:SetCondition(c24842059.discon)
	e1:SetCost(c24842059.discost)
	e1:SetTarget(c24842059.distg)
	e1:SetOperation(c24842059.disop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24842059,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,24842060)
	e2:SetCost(c24842059.spcost)
	e2:SetTarget(c24842059.sptg)
	e2:SetOperation(c24842059.spop)
	c:RegisterEffect(e2)
end
function c24842059.mfilter(c)
	return c:IsLevelBelow(4) and c:IsLinkRace(RACE_CYBERSE)
end
function c24842059.discon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainDisablable(ev)
end
function c24842059.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c24842059.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.nbcon(tp,re) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
	if re:GetActivateLocation()==LOCATION_GRAVE then
		e:SetCategory(e:GetCategory()|CATEGORY_GRAVE_ACTION)
	else
		e:SetCategory(e:GetCategory()&~CATEGORY_GRAVE_ACTION)
	end
end
function c24842059.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
end
function c24842059.cfilter(c,tp)
	return c:IsSetCard(0x135) and c:IsSummonLocation(LOCATION_EXTRA) and Duel.GetMZoneCount(tp,c)>0
end
function c24842059.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c24842059.cfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c24842059.cfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c24842059.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c24842059.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
