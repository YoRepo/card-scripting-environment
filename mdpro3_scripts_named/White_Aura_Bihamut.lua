--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: White Aura Bihamut  (ID: 89907227)
-- Type: Monster / Effect / Synchro
-- Attribute: WATER
-- Race: Fish
-- Level: 10
-- ATK 3300 | DEF 3000
-- Setcode: 0x1a7
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner Synchro Monster + 1+ non-Tuner monsters
-- During your turn, when this card is Synchro Summoned: You can Special Summon 1 "Divine Dragon Token"
-- (Fish/WATER/Level 10/ATK 3300/DEF 3000) in Defense Position.
-- Once per opponent's turn, while you control no Tokens (Quick Effect): You can Special Summon 1
-- "Divine Dragon Token".
-- If this card you control is destroyed by an opponent's card effect and sent to your GY, while you
-- control a "Divine Dragon Token": You can Special Summon this card in Defense Position.
--[[ __CARD_HEADER_END__ ]]

--白闘気双頭神龍
function c89907227.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89907227,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c89907227.tkcon)
	e1:SetTarget(c89907227.tktg)
	e1:SetOperation(c89907227.tkop)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(89907227,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,TIMING_BATTLE_START+TIMING_END_PHASE)
	e2:SetCondition(c89907227.tkcon2)
	e2:SetTarget(c89907227.tktg)
	e2:SetOperation(c89907227.tkop2)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(89907227,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_ACTIVATE_CONDITION)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c89907227.spcon)
	e3:SetTarget(c89907227.sptg)
	e3:SetOperation(c89907227.spop)
	c:RegisterEffect(e3)
end
c89907227.material_type=TYPE_SYNCHRO
function c89907227.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c89907227.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsPlayerCanSpecialSummonMonster(tp,89907228,0,TYPES_TOKEN_MONSTER,3300,3000,10,RACE_FISH,ATTRIBUTE_WATER,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c89907227.tkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,89907228,0,TYPES_TOKEN_MONSTER,3300,3000,10,RACE_FISH,ATTRIBUTE_WATER,POS_FACEUP_DEFENSE) then
		local token=Duel.CreateToken(tp,89907228)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c89907227.tkcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsTurnPlayer(1-tp) and not aux.tkfcon(e,tp)
end
function c89907227.tkop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,89907228,0,TYPES_TOKEN_MONSTER,3300,3000,10,RACE_FISH,ATTRIBUTE_WATER) then
		local token=Duel.CreateToken(tp,89907228)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c89907227.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and rp==1-tp and c:IsReason(REASON_EFFECT)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_ONFIELD,0,1,nil,89907228)
end
function c89907227.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c89907227.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
