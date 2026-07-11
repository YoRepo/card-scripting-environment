--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Armades, Keeper of Boundaries  (ID: 88033975)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Fiend
-- Level: 5
-- ATK 2300 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1 or more non-Tuner monsters
-- If this card attacks or is attacked, your opponent cannot activate cards or effects until the end of
-- the Damage Step.
--[[ __CARD_HEADER_END__ ]]

--幻層の守護者アルマデス
function c88033975.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(1)
	e1:SetCondition(c88033975.actcon)
	c:RegisterEffect(e1)
end
function c88033975.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
