--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Dododo Bot  (ID: 19700943)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 1800 | DEF 1900
-- Setcode: 0x82
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Normal Summoned (but can be Normal Set).
-- If this card attacks, it is unaffected by other card effects until the end of the Damage Step.
--[[ __CARD_HEADER_END__ ]]

--ドドドボット
function c19700943.initial_effect(c)
	--summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c19700943.sumcon)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetCondition(c19700943.immcon)
	e2:SetValue(c19700943.efilter)
	c:RegisterEffect(e2)
end
function c19700943.sumcon(e,c,minc)
	if not c then return true end
	return false
end
function c19700943.immcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c19700943.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
