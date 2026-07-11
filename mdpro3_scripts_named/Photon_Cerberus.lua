--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Photon Cerberus  (ID: 28990150)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 3
-- ATK 1300 | DEF 600
-- Setcode: 0x55
-- Scope: OCG / TCG
--
-- Effect Text:
-- During the turn this card was Normal Summoned, neither player can activate Trap Cards while this
-- card is face-up on the field.
--[[ __CARD_HEADER_END__ ]]

--フォトン・ケルベロス
function c28990150.initial_effect(c)
	--actlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetOperation(c28990150.atkop)
	c:RegisterEffect(e3)
end
function c28990150.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c28990150.aclimit)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c28990150.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsType(TYPE_TRAP)
end
