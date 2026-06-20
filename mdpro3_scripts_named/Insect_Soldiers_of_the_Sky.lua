--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 空中的昆虫兵  (ID: 7019529)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 3
-- ATK 1000 | DEF 800
--
-- Effect Text:
-- 攻击风属性的怪兽时，伤害阶段时攻击力上升1000。
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
