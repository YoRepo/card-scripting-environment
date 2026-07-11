--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Luminous Soldier  (ID: 57482479)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 5
-- ATK 2100 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card battles with a DARK monster, increase the ATK of this card by 500 points during the
-- Damage Step.
--[[ __CARD_HEADER_END__ ]]

--太陽の戦士
function c57482479.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c57482479.condtion)
	e1:SetValue(500)
	c:RegisterEffect(e1)
end
function c57482479.condtion(e)
	local ph=Duel.GetCurrentPhase()
	if not (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) or not e:GetHandler():IsRelateToBattle() then return false end
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:IsFaceup() and bc:IsAttribute(ATTRIBUTE_DARK)
end
