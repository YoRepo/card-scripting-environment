--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Legendary Fiend  (ID: 99747800)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 6
-- ATK 1500 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during your Standby Phase: This card gains 700 ATK.
--[[ __CARD_HEADER_END__ ]]

--レジェンド・デビル
function c99747800.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99747800,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c99747800.atkcon)
	e1:SetOperation(c99747800.atkop)
	c:RegisterEffect(e1)
end
function c99747800.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c99747800.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	e1:SetValue(700)
	c:RegisterEffect(e1)
end
