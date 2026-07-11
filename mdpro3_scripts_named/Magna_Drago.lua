--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Magna Drago  (ID: 36750412)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Dragon
-- Level: 2
-- ATK 1400 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card inflicts battle damage to your opponent: It gains 200 ATK.
--[[ __CARD_HEADER_END__ ]]

--炎龍
function c36750412.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36750412,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c36750412.atkcon)
	e1:SetOperation(c36750412.atkop)
	c:RegisterEffect(e1)
end
function c36750412.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c36750412.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
