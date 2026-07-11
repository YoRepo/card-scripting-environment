--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Fluffal Leo  (ID: 66457138)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level: 4
-- ATK 1600 | DEF 1200
-- Setcode: 0xa9
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card declares an attack: It gains 500 ATK until the end of the Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--ファーニマル・ライオ
function c66457138.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetOperation(c66457138.atkop)
	c:RegisterEffect(e1)
end
function c66457138.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
