--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Performapal Cheermole  (ID: 17857780)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Beast
-- Level: 2
-- ATK 600 | DEF 1000
-- Pendulum Scale: L5 / R5
-- Setcode: 0x9f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 5
-- [ Pendulum Effect ]
-- All Pendulum Monsters you control gain 300 ATK.
-- ----------------------------------------
-- [ Monster Effect ]
-- You can target 1 monster whose current ATK is different from its original ATK; apply the appropriate
-- effect.
-- You can only use this effect of "Performapal Cheermole" once per turn.
-- ● If that monster's current ATK is higher than its original ATK, it gains 1000 ATK.
-- ● If that monster's current ATK is lower than its original ATK, it loses 1000 ATK.
--[[ __CARD_HEADER_END__ ]]

--EMチアモール
function c17857780.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c17857780.atktg)
	e2:SetValue(300)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17857780,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,17857780)
	e3:SetTarget(c17857780.target)
	e3:SetOperation(c17857780.operation)
	c:RegisterEffect(e3)
end
function c17857780.atktg(e,c)
	return c:IsType(TYPE_PENDULUM)
end
function c17857780.filter(c)
	return c:IsFaceup() and not c:IsAttack(c:GetBaseAttack())
end
function c17857780.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c17857780.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c17857780.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c17857780.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c17857780.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=tc:GetAttack()
		local batk=tc:GetBaseAttack()
		if atk==batk then return end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		if atk>batk then
			e1:SetValue(1000)
		else
			e1:SetValue(-1000)
		end
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
