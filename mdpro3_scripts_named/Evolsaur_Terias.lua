--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Evolsaur Terias  (ID: 69633792)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dinosaur
-- Level: 6
-- ATK 2400 | DEF 600
-- Setcode: 0x604e
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Special Summoned by the effect of an "Evoltile" monster: This card loses 500 ATK.
--[[ __CARD_HEADER_END__ ]]

--エヴォルダー・テリアス
function c69633792.initial_effect(c)
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69633792,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(aux.evospcon)
	e1:SetOperation(c69633792.atkop)
	c:RegisterEffect(e1)
end
function c69633792.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		--atkup
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
