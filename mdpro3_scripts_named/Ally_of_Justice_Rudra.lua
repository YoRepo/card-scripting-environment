--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 正义盟军 风哮怪  (ID: 52265835)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 5
-- ATK 1900 | DEF 1200
-- Setcode: 1
--
-- Effect Text:
-- 这张卡和光属性怪兽进行战斗的场合，伤害步骤内这张卡的攻击力上升700。
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
