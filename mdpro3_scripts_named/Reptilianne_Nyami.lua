--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Reptilianne Nyami  (ID: 42090294)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Reptile
-- Level: 2
-- ATK 200 | DEF 0
-- Setcode: 0x3c
-- Scope: OCG / TCG
--
-- Effect Text:
-- During the Main Phase, if you have a Reptile monster in your GY (Quick Effect): You can send this
-- card from your hand to the GY, then target 1 face-up monster your opponent controls; change its ATK
-- to 0.
-- If your opponent controls a monster with 0 ATK: You can Special Summon this card from your GY.
-- You can only use 1 "Reptilianne Nyami" effect per turn, and only once that turn.
--[[ __CARD_HEADER_END__ ]]

--レプティレス・ニャミニ
function c42090294.initial_effect(c)
	--change atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42090294,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCountLimit(1,42090294)
	e1:SetCondition(c42090294.atkcon)
	e1:SetCost(c42090294.atkcost)
	e1:SetTarget(c42090294.atktg)
	e1:SetOperation(c42090294.atkop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(42090294,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,42090294)
	e2:SetCondition(c42090294.spcon)
	e2:SetTarget(c42090294.sptg)
	e2:SetOperation(c42090294.spop)
	c:RegisterEffect(e2)
end
function c42090294.cfilter1(c)
	return c:IsRace(RACE_REPTILE)
end
function c42090294.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c42090294.cfilter1,tp,LOCATION_GRAVE,0,1,nil)
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c42090294.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() end
	Duel.SendtoGrave(c,REASON_COST)
end
function c42090294.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and aux.nzatk(chkc) end
	if chk==0 then return Duel.IsExistingTarget(aux.nzatk,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,aux.nzatk,tp,0,LOCATION_MZONE,1,1,nil)
end
function c42090294.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c42090294.cfilter2(c)
	return c:IsFaceup() and c:IsAttack(0)
end
function c42090294.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c42090294.cfilter2,tp,0,LOCATION_MZONE,1,nil)
end
function c42090294.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c42090294.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
