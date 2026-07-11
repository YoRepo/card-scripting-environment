--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Naturia Guardian  (ID: 80555116)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 4
-- ATK 1600 | DEF 400
-- Setcode: 0x2a, 0x52
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent Normal Summons a monster: This card gains 300 ATK until the end of this turn.
--[[ __CARD_HEADER_END__ ]]

--ナチュル・ガーディアン
function c80555116.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80555116,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c80555116.atkcon)
	e1:SetOperation(c80555116.atkop)
	c:RegisterEffect(e1)
end
function c80555116.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c80555116.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
