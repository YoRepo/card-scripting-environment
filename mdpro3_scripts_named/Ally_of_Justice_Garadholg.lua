--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 正义盟军 雷剑兵  (ID: 25771826)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1600 | DEF 400
-- Setcode: 1
--
-- Effect Text:
-- 这张卡和光属性怪兽进行战斗的场合，伤害步骤内这张卡的攻击力上升200。
--[[ __CARD_HEADER_END__ ]]

--A・O・J ガラドホルグ
function c25771826.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c25771826.condtion)
	e1:SetValue(200)
	c:RegisterEffect(e1)
end
function c25771826.condtion(e)
	local ph=Duel.GetCurrentPhase()
	if not (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (a==e:GetHandler() and d and d:IsFaceup() and d:IsAttribute(ATTRIBUTE_LIGHT))
		or (d==e:GetHandler() and a:IsAttribute(ATTRIBUTE_LIGHT))
end
