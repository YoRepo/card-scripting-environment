--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Nine-Lives Cat  (ID: 28981598)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Zombie
-- Rank: 9
-- ATK 900 | DEF 3300
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 9 monsters
-- Your opponent cannot target other monsters you control, that were Special Summoned from the GY, with
-- card effects.
-- You can detach 1 material from this card, then target 1 Level 9 monster in your GY or 1 monster in
-- your opponent's GY; Special Summon it.
-- You can only use this effect of "Nine-Lives Cat" once per turn.
--[[ __CARD_HEADER_END__ ]]

--九魂猫
function c28981598.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,2)
	c:EnableReviveLimit()
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c28981598.tgtg)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(28981598,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,28981598)
	e2:SetCost(c28981598.spcost)
	e2:SetTarget(c28981598.sptg)
	e2:SetOperation(c28981598.spop)
	c:RegisterEffect(e2)
end
function c28981598.tgtg(e,c)
	return c:IsSummonLocation(LOCATION_GRAVE) and c~=e:GetHandler()
end
function c28981598.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c28981598.spfilter(c,e,tp)
	return (c:IsLevel(9) or c:IsControler(1-tp)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c28981598.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c28981598.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c28981598.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c28981598.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c28981598.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
