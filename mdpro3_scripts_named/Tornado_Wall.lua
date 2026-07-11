--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Tornado Wall  (ID: 18605135)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only if "Umi" is on the field.
-- While "Umi" is on the field, you take no battle damage.
-- If "Umi" is not on the field, destroy this card.
--[[ __CARD_HEADER_END__ ]]

--竜巻海流壁
function c18605135.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c18605135.actcon)
	c:RegisterEffect(e1)
	--avoid battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetCondition(c18605135.abdcon)
	c:RegisterEffect(e2)
	--self destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c18605135.sdcon)
	c:RegisterEffect(e3)
end
function c18605135.check()
	return Duel.IsEnvironment(22702055)
end
function c18605135.actcon(e,tp,eg,ep,ev,re,r,rp)
	return c18605135.check()
end
function c18605135.abdcon(e)
	local at=Duel.GetAttackTarget()
	return c18605135.check() and (at==nil or at:IsAttackPos() or Duel.GetAttacker():GetAttack()>at:GetDefense())
end
function c18605135.sdcon(e)
	return not c18605135.check()
end
