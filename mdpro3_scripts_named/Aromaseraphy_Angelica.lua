--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Aromaseraphy Angelica  (ID: 16759958)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Plant
-- Level: 1
-- ATK 0 | DEF 0
-- Setcode: 0xc9
-- Scope: OCG / TCG
--
-- Effect Text:
-- (Quick Effect): You can discard this card, then target 1 "Aroma" monster in your GY; gain LP equal
-- to that target's ATK.
-- While your LP is higher than your opponent's, you control an "Aroma" monster, and this card is in
-- your GY: You can Special Summon this card, but banish it when it leaves the field.
-- You can only use each effect of "Aromaseraphy Angelica" once per turn.
--[[ __CARD_HEADER_END__ ]]

--アロマセラフィ－アンゼリカ
function c16759958.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16759958,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,16759958)
	e1:SetCost(c16759958.reccost)
	e1:SetTarget(c16759958.rectg)
	e1:SetOperation(c16759958.recop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(16759958,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,16759959)
	e2:SetCondition(c16759958.spcon)
	e2:SetTarget(c16759958.sptg)
	e2:SetOperation(c16759958.spop)
	c:RegisterEffect(e2)
end
function c16759958.reccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c16759958.recfilter(c)
	return c:IsSetCard(0xc9) and c:GetAttack()>0
end
function c16759958.rectg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c16759958.recfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c16759958.recfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c16759958.recfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetFirst():GetAttack())
end
function c16759958.recop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:GetAttack()>0 then
		Duel.Recover(tp,tc:GetAttack(),REASON_EFFECT)
	end
end
function c16759958.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xc9)
end
function c16759958.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)>Duel.GetLP(1-tp) and Duel.IsExistingMatchingCard(c16759958.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c16759958.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c16759958.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end
