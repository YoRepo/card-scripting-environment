--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Infernity Beast  (ID: 7264861)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level: 3
-- ATK 1600 | DEF 1200
-- Setcode: 0xb
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks while you have no cards in your hand, your opponent cannot activate any Spell
-- or Trap Cards until after the Damage Step.
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・ビースト
function c7264861.initial_effect(c)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c7264861.aclimit)
	e1:SetCondition(c7264861.condition)
	c:RegisterEffect(e1)
end
function c7264861.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 and Duel.GetAttacker()==e:GetHandler()
end
function c7264861.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
