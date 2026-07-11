--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Crystal Beast Topaz Tiger  (ID: 95600067)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 4
-- ATK 1600 | DEF 1000
-- Setcode: 0x1034
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks an opponent's monster, it gains 400 ATK during the Damage Step only.
-- If this face-up card is destroyed in a Monster Zone, you can place it face-up in your Spell & Trap
-- Zone as a Continuous Spell, instead of sending it to the GY.
--[[ __CARD_HEADER_END__ ]]

--宝玉獣 トパーズ・タイガー
function c95600067.initial_effect(c)
	--send replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TO_GRAVE_REDIRECT_CB)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c95600067.repcon)
	e1:SetOperation(c95600067.repop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c95600067.condition)
	e2:SetValue(400)
	c:RegisterEffect(e2)
end
function c95600067.repcon(e)
	local c=e:GetHandler()
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsReason(REASON_DESTROY)
end
function c95600067.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
	e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
	c:RegisterEffect(e1)
end
function c95600067.condition(e)
	local phase=Duel.GetCurrentPhase()
	return (phase==PHASE_DAMAGE or phase==PHASE_DAMAGE_CAL)
		and Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil
end
