--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Sweet Corn  (ID: 74983881)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 2
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during your Main Phase 2: You can pay 500 Life Points; Special Summon 1 "Maize Token"
-- (Plant-Type/EARTH/Level 1/ATK 0/DEF 0).
--[[ __CARD_HEADER_END__ ]]

--モロコシーナ
function c74983881.initial_effect(c)
	--coin effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74983881,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c74983881.spcon)
	e1:SetCost(c74983881.spcost)
	e1:SetTarget(c74983881.sptg)
	e1:SetOperation(c74983881.spop)
	c:RegisterEffect(e1)
end
function c74983881.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c74983881.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c74983881.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,74983882,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c74983881.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,74983882,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,74983882)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
