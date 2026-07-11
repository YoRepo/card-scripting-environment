--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Hallohallo  (ID: 77994337)
-- Type: Monster / Normal / Tuner / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level: 3
-- ATK 800 | DEF 600
-- Pendulum Scale: L2 / R2
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 2
-- [ Pendulum Effect ]
-- Once per turn: You can target 1 face-up monster on the field; roll a six-sided die and that
-- monster's Level becomes the same as the result until the end of this turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- Hallo Hallo, brain of tallow,
-- Guts are gone, noggin's hollow.
-- Seeking sweets and marshing mallows,
-- Watch your back, and your candy sack.
--[[ __CARD_HEADER_END__ ]]

--ハロハロ
function c77994337.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--level
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77994337,0))
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c77994337.lvtg)
	e1:SetOperation(c77994337.lvop)
	c:RegisterEffect(e1)
end
function c77994337.lvfilter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c77994337.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c77994337.lvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c77994337.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c77994337.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c77994337.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local dc=Duel.TossDice(tp,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(dc)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
