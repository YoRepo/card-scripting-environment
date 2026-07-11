--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: TGX300  (ID: 58258899)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- All face-up monsters you control gain 300 ATK for each "T.G." monster you control.
--[[ __CARD_HEADER_END__ ]]

--TGX300
function c58258899.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(c58258899.val)
	c:RegisterEffect(e2)
end
function c58258899.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x27)
end
function c58258899.val(e,c)
	return Duel.GetMatchingGroupCount(c58258899.filter,c:GetControler(),LOCATION_MZONE,0,nil)*300
end
