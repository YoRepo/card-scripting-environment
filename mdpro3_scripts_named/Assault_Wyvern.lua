--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Assault Wyvern  (ID: 29311166)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 4
-- ATK 1800 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card destroys an opponent's monster by battle: You can Tribute this card; Special Summon 1
-- Dragon-Type monster from your hand or Graveyard, except "Assault Wyvern".
--[[ __CARD_HEADER_END__ ]]

--アサルトワイバーン
function c29311166.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29311166,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdocon)
	e1:SetCost(c29311166.cost)
	e1:SetTarget(c29311166.target)
	e1:SetOperation(c29311166.operation)
	c:RegisterEffect(e1)
end
function c29311166.filter(c,e,tp)
	return c:IsRace(RACE_DRAGON) and not c:IsCode(29311166) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29311166.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c29311166.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c29311166.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c29311166.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c29311166.filter),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
