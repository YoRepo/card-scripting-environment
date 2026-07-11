--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Dark City  (ID: 53527835)
-- Type: Spell / Field
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a "Destiny HERO" monster attacks a monster with a higher ATK, the attacking monster gains 1000
-- ATK during damage calculation only.
--[[ __CARD_HEADER_END__ ]]

--ダーク・シティ
function c53527835.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c53527835.atkcon)
	e2:SetTarget(c53527835.atktg)
	e2:SetValue(c53527835.atkval)
	c:RegisterEffect(e2)
end
function c53527835.atkcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()
end
function c53527835.atktg(e,c)
	return c==Duel.GetAttacker() and c:IsSetCard(0xc008)
end
function c53527835.atkval(e,c)
	local d=Duel.GetAttackTarget()
	if c:GetAttack()<d:GetAttack() then
		return 1000
	else return 0 end
end
