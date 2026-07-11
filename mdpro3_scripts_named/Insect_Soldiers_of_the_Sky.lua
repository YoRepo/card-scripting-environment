--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Insect Soldiers of the Sky  (ID: 7019529)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level: 3
-- ATK 1000 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- The ATK of this card increases by 1000 points whenever it attacks a WIND monster.
--[[ __CARD_HEADER_END__ ]]

--空の昆虫兵
function c7019529.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c7019529.condtion)
	e1:SetValue(1000)
	c:RegisterEffect(e1)
end
function c7019529.condtion(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
		and Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil
		and Duel.GetAttackTarget():IsFaceup() and Duel.GetAttackTarget():IsAttribute(ATTRIBUTE_WIND)
end
