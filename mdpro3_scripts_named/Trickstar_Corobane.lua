--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Trickstar Corobane  (ID: 98169343)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 5
-- ATK 2000 | DEF 1000
-- Setcode: 0xfb
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control no monsters, or all monsters you control are "Trickstar" monsters: You can Special
-- Summon this card from your hand.
-- During the Damage Step, when your "Trickstar" monster battles an opponent's monster (Quick Effect):
-- You can send this card from your hand to the GY; that monster you control gains ATK equal to its
-- original ATK until the end of this turn.
-- You can only use 1 "Trickstar Corobane" effect per turn, and only once that turn.
--[[ __CARD_HEADER_END__ ]]

--トリックスター・キャロベイン
function c98169343.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98169343,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,98169343)
	e1:SetCondition(c98169343.spcon)
	e1:SetTarget(c98169343.sptg)
	e1:SetOperation(c98169343.spop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98169343,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_HAND)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCountLimit(1,98169343)
	e2:SetCondition(c98169343.atkcon)
	e2:SetCost(c98169343.atkcost)
	e2:SetOperation(c98169343.atkop)
	c:RegisterEffect(e2)
end
function c98169343.cfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0xfb)
end
function c98169343.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c98169343.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c98169343.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c98169343.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c98169343.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if ph~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup() and tc:IsSetCard(0xfb) and tc:IsRelateToBattle() and Duel.GetAttackTarget()~=nil
end
function c98169343.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c98169343.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() and tc:IsFaceup() and tc:IsControler(tp) then
		local atk=tc:GetBaseAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
