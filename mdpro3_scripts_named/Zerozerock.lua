--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Zerozerock  (ID: 85446833)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent cannot target face-up Attack Position monsters with 0 ATK for attacks.
--[[ __CARD_HEADER_END__ ]]

--ゼロゼロック
function c85446833.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atklimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c85446833.target)
	c:RegisterEffect(e2)
end
function c85446833.target(e,c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsAttack(0)
end
