--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Ghostrick Festival  (ID: 35871958)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Spellcaster
-- Link Rating: 1
-- Link Arrows: Bottom
-- ATK 0
-- Setcode: 0x8d
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 non-Link "Ghostrick" monster
-- You can also use a face-down "Ghostrick" monster you control as material to Link Summon this card.
-- While a "Ghostrick" card is in a Field Zone, your "Ghostrick" monsters can attack directly.
-- When an opponent's monster declares an attack: You can Tribute this card; Special Summon 1
-- "Ghostrick" monster from your Deck in face-down Defense Position.
-- You can only use this effect of "Ghostrick Festival" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ゴーストリック・フェスティバル
function c35871958.initial_effect(c)
	--link summon
	local e0=aux.AddLinkProcedure(c,c35871958.matfilter,1,1)
	e0:SetProperty(e0:GetProperty()|EFFECT_FLAG_SET_AVAILABLE)
	c:EnableReviveLimit()
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c35871958.dacon)
	e1:SetTarget(c35871958.datg)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(35871958,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,35871958)
	e2:SetCondition(c35871958.spcon)
	e2:SetCost(c35871958.spcost)
	e2:SetTarget(c35871958.sptg)
	e2:SetOperation(c35871958.spop)
	c:RegisterEffect(e2)
end
function c35871958.matfilter(c)
	return c:IsLinkSetCard(0x8d) and not c:IsLinkType(TYPE_LINK)
end
function c35871958.dacfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8d)
end
function c35871958.dacon(e)
	return Duel.IsExistingMatchingCard(c35871958.dacfilter,e:GetHandlerPlayer(),LOCATION_FZONE,LOCATION_FZONE,1,nil)
end
function c35871958.datg(e,c)
	return c:IsSetCard(0x8d)
end
function c35871958.spcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c35871958.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c35871958.spfilter(c,e,tp)
	return c:IsSetCard(0x8d) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c35871958.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>0
		and Duel.IsExistingMatchingCard(c35871958.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c35871958.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c35871958.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,g)
	end
end
