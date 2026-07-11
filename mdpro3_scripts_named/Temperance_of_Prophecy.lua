--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Temperance of Prophecy  (ID: 87608852)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Spellcaster
-- Level: 3
-- ATK 1000 | DEF 1000
-- Setcode: 0x6e
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Main Phase, if you have activated a "Spellbook" Spell Card previously this turn: You can
-- Tribute this card; Special Summon 1 Level 5 or higher LIGHT or DARK Spellcaster-Type monster from
-- your Deck.
-- You cannot Special Summon another Level 5 or higher monster during the turn you activate this
-- effect.
--[[ __CARD_HEADER_END__ ]]

--魔導召喚士 テンペル
function c87608852.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87608852,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c87608852.spcost)
	e1:SetTarget(c87608852.sptg)
	e1:SetOperation(c87608852.spop)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(87608852,ACTIVITY_SPSUMMON,c87608852.counterfilter)
	Duel.AddCustomActivityCounter(87608852,ACTIVITY_CHAIN,c87608852.chainfilter)
end
function c87608852.counterfilter(c)
	return not c:IsLevelAbove(5)
end
function c87608852.chainfilter(re,tp,cid)
	return not (re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and re:GetHandler():IsSetCard(0x106e))
end
function c87608852.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable()
		and Duel.GetCustomActivityCount(87608852,tp,ACTIVITY_SPSUMMON)==0
		and Duel.GetCustomActivityCount(87608852,tp,ACTIVITY_CHAIN)>0 end
	Duel.Release(e:GetHandler(),REASON_COST)
	--oath effects
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c87608852.splimit)
	e1:SetLabelObject(e)
	Duel.RegisterEffect(e1,tp)
end
function c87608852.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return e:GetLabelObject()~=se and c:IsLevelAbove(5)
end
function c87608852.spfilter(c,e,tp)
	return c:IsLevelAbove(5) and c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(0x30)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c87608852.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c87608852.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c87608852.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c87608852.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
