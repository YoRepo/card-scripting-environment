--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Warlock of the Ice Barrier  (ID: 18482591)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level: 3
-- ATK 400 | DEF 1000
-- Setcode: 0x2f
-- Scope: OCG / TCG
--
-- Effect Text:
-- While you control another "Ice Barrier" monster, both players must Set Spell Cards before activating
-- them, and cannot activate them until their next turn.
--[[ __CARD_HEADER_END__ ]]

--氷結界の破術師
function c18482591.initial_effect(c)
	--cannot activate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,1)
	e2:SetCondition(c18482591.con)
	e2:SetValue(c18482591.aclimit)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SSET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c18482591.con)
	e3:SetOperation(c18482591.aclimset)
	c:RegisterEffect(e3)
end
function c18482591.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2f)
end
function c18482591.con(e)
	return Duel.IsExistingMatchingCard(c18482591.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c18482591.aclimit(e,re,tp)
	if not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsActiveType(TYPE_SPELL) then return false end
	local c=re:GetHandler()
	return not c:IsLocation(LOCATION_SZONE) or c:GetFlagEffect(18482591)>0
end
function c18482591.aclimset(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		local reset=tc:IsControler(tp) and RESET_OPPO_TURN or RESET_SELF_TURN
		tc:RegisterFlagEffect(18482591,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+reset,0,1)
		tc=eg:GetNext()
	end
end
