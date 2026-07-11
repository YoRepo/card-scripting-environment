--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Leotaur  (ID: 98225108)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1500 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card battles a non-Normal Monster, this card gains 500 ATK during the Damage Step only.
--[[ __CARD_HEADER_END__ ]]

--レオンタウロス
function c98225108.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c98225108.condtion)
	e1:SetValue(500)
	c:RegisterEffect(e1)
end
function c98225108.condtion(e)
	local ph=Duel.GetCurrentPhase()
	local bc=e:GetHandler():GetBattleTarget()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and bc and not bc:IsType(TYPE_NORMAL)
end
