--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Serpent Suppression  (ID: 19451302)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Face-up Attack Position monsters with 0 ATK your opponent controls cannot be destroyed by battle
-- with "Reptilianne" monsters.
--[[ __CARD_HEADER_END__ ]]

--スネーク・チョーク
function c19451302.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c19451302.indtg)
	e2:SetValue(aux.TargetBoolFunction(Card.IsSetCard,0x3c))
	c:RegisterEffect(e2)
end
function c19451302.indtg(e,c)
	return c:IsAttack(0) and c:IsAttackPos()
end
