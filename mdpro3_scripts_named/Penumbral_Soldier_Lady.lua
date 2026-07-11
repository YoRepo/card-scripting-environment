--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Penumbral Soldier Lady  (ID: 64751286)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 6
-- ATK 2100 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card battles a LIGHT monster, this card gains 1000 ATK during the Damage Step only.
--[[ __CARD_HEADER_END__ ]]

--月の女戦士
function c64751286.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c64751286.condtion)
	e1:SetValue(1000)
	c:RegisterEffect(e1)
end
function c64751286.condtion(e)
	local c=e:GetHandler()
	local ph=Duel.GetCurrentPhase()
	local bc=c:GetBattleTarget()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
		and c:IsRelateToBattle() and bc and bc:IsFaceup() and bc:IsAttribute(ATTRIBUTE_LIGHT)
end
