--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Dark Lucius LV6  (ID: 12817939)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level: 6
-- ATK 1700 | DEF 600
-- Setcode: 0x41
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card was Special Summoned by the effect of "Dark Lucius LV4", negate the effects of your
-- opponent's monsters destroyed by battle with this card.
-- Once per turn, during the Standby Phase of your next turn after this card negated your opponent's
-- monster effect by this effect: You can send this card to the GY; Special Summon 1 "Dark Lucius LV8"
-- from your hand or Deck.
--[[ __CARD_HEADER_END__ ]]

--漆黒の魔王 LV6
function c12817939.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c12817939.disop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(12817939,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCondition(c12817939.spcon)
	e2:SetCost(c12817939.spcost)
	e2:SetTarget(c12817939.sptg)
	e2:SetOperation(c12817939.spop)
	c:RegisterEffect(e2)
end
c12817939.lvup={85313220,58206034}
c12817939.lvdn={85313220}
function c12817939.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.GetAttackTarget()
	if d==c then d=Duel.GetAttacker() end
	if d and d:IsStatus(STATUS_BATTLE_DESTROYED) and d:IsType(TYPE_EFFECT)
		and c:GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_LV and not c:IsStatus(STATUS_BATTLE_DESTROYED) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x17a0000)
		d:RegisterEffect(e1)
		c:RegisterFlagEffect(12817939,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,2)
	end
end
function c12817939.spcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetFlagEffect(12817939)~=0
end
function c12817939.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c12817939.spfilter(c,e,tp)
	return c:IsCode(58206034) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c12817939.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c12817939.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c12817939.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c12817939.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,SUMMON_VALUE_LV,tp,tp,true,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
