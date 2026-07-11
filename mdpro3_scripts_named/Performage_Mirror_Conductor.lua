--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Performage Mirror Conductor  (ID: 71578874)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 4
-- ATK 600 | DEF 1400
-- Pendulum Scale: L3 / R3
-- Setcode: 0xc6
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 3
-- [ Pendulum Effect ]
-- Once per turn: You can target 1 face-up Special Summoned monster on the field; its ATK and DEF
-- become equal to its current ATK or DEF (whichever is lower) until the end of this turn (even if this
-- card leaves the field).
-- ----------------------------------------
-- [ Monster Effect ]
-- Once per turn (Quick Effect): You can target 1 face-up monster on the field; switch its current ATK
-- and DEF (until the end of this turn), then take 500 damage.
--[[ __CARD_HEADER_END__ ]]

--Emミラー・コンダクター
function c71578874.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c71578874.adtg)
	e2:SetOperation(c71578874.adop)
	c:RegisterEffect(e2)
	--swap
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetHintTiming(TIMING_DAMAGE_STEP)
	e3:SetCountLimit(1)
	e3:SetCondition(aux.dscon)
	e3:SetTarget(c71578874.swtg)
	e3:SetOperation(c71578874.swop)
	c:RegisterEffect(e3)
end
function c71578874.filter(c)
	return c:IsFaceup() and not c:IsAttack(c:GetDefense()) and c:IsDefenseAbove(0)
		and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c71578874.adtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c71578874.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c71578874.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c71578874.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c71578874.adop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local val=math.min(tc:GetAttack(),tc:GetDefense())
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(val)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		tc:RegisterEffect(e2)
	end
end
function c71578874.swfilter(c)
	return c:IsFaceup() and c:IsDefenseAbove(0)
end
function c71578874.swtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c71578874.swfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c71578874.swfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c71578874.swfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,500)
end
function c71578874.swop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		local def=tc:GetDefense()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(def)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(atk)
		tc:RegisterEffect(e2)
		Duel.BreakEffect()
		Duel.Damage(tp,500,REASON_EFFECT)
	end
end
