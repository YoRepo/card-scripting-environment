--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Ally of Justice Rudra  (ID: 52265835)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 5
-- ATK 1900 | DEF 1200
-- Setcode: 0x1
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card battles a LIGHT monster, it gains 700 ATK during the Damage Step only.
--[[ __CARD_HEADER_END__ ]]

--A・O・J ルドラ
function c52265835.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c52265835.condtion)
	e1:SetValue(700)
	c:RegisterEffect(e1)
end
function c52265835.condtion(e)
	local ph=Duel.GetCurrentPhase()
	if not (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (a==e:GetHandler() and d and d:IsFaceup() and d:IsAttribute(ATTRIBUTE_LIGHT))
		or (d==e:GetHandler() and a:IsAttribute(ATTRIBUTE_LIGHT))
end
