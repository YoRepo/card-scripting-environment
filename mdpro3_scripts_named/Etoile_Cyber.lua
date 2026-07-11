--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Etoile Cyber  (ID: 11460577)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1200 | DEF 1600
-- Setcode: 0x93
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks directly, it gains 500 ATK during the Damage Step only.
--[[ __CARD_HEADER_END__ ]]

--エトワール・サイバー
function c11460577.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c11460577.condtion)
	e1:SetValue(500)
	c:RegisterEffect(e1)
end
function c11460577.condtion(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
		and Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()==nil
end
