--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 太阳之战士  (ID: 57482479)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 5
-- ATK 2100 | DEF 1400
--
-- Effect Text:
-- 和暗属性的怪兽战斗的场合，伤害计算阶段这张卡的攻击力上升500。
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
