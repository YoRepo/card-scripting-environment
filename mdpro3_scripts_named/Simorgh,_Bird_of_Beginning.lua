--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Simorgh, Bird of Beginning  (ID: 50820852)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 1
-- ATK 0 | DEF 1600
-- Setcode: 0x12d
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can activate this effect; during your Main Phase this turn,
-- you can Normal Summon 1 "Simorgh" monster in addition to your Normal Summon/Set.
-- (You can only gain this effect once per turn.)
-- If this card is in your GY and your opponent controls no cards in their Spell & Trap Zone: You can
-- Special Summon this card in Defense Position, but banish it when it leaves the field, also you
-- cannot Special Summon monsters for the rest of this turn, except Winged Beast monsters.
-- You can only use each effect of "Simorgh, Bird of Beginning" once per turn.
--[[ __CARD_HEADER_END__ ]]

--雛神鳥シムルグ
function c50820852.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50820852,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,50820852)
	e1:SetTarget(c50820852.sumtg)
	e1:SetOperation(c50820852.sumop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(50820852,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,50820853)
	e2:SetCondition(c50820852.spcon)
	e2:SetTarget(c50820852.sptg)
	e2:SetOperation(c50820852.spop)
	c:RegisterEffect(e2)
end
function c50820852.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSummon(tp) and Duel.IsPlayerCanAdditionalSummon(tp)
		and Duel.GetFlagEffect(tp,50820852)==0 and Duel.GetTurnPlayer()==tp end
end
function c50820852.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,50820852)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(50820852,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x12d))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,50820852,RESET_PHASE+PHASE_END,0,1)
end
function c50820852.cfilter(c)
	return c:GetSequence()<5
end
function c50820852.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c50820852.cfilter,tp,0,LOCATION_SZONE,1,nil)
end
function c50820852.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c50820852.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		c:RegisterEffect(e1,true)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c50820852.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c50820852.splimit(e,c)
	return not c:IsRace(RACE_WINDBEAST)
end
