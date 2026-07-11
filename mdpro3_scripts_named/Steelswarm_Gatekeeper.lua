--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Steelswarm Gatekeeper  (ID: 26722601)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 1500 | DEF 1900
-- Setcode: 0x100a
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a "Steelswarm" monster is Tribute Summoned face-up while this card is face-up on the field, you
-- can Normal Summon or Set 1 monster in addition to your Normal Summon or Set that turn.
--[[ __CARD_HEADER_END__ ]]

--インヴェルズの門番
function c26722601.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c26722601.sumop)
	c:RegisterEffect(e1)
end
function c26722601.sumop(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	local c=e:GetHandler()
	if ec~=e:GetHandler() and ec:IsSetCard(0x100a) and ec:IsSummonType(SUMMON_TYPE_ADVANCE) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(26722601,0))
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
		e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_EXTRA_SET_COUNT)
		c:RegisterEffect(e2)
	end
end
