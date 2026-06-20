--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 复王龙EX  (ID: 18000338)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dinosaur
-- Level 4
-- ATK 1900 | DEF 1200
--
-- Effect Text:
-- ①：这张卡和额外怪兽区域的怪兽进行战斗的场合，只在伤害步骤内这张卡的攻击力·守备力上升800。
--[[ __CARD_HEADER_END__ ]]

--Re：EX
function c18000338.initial_effect(c)
	--increase atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c18000338.condition)
	e1:SetValue(800)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c18000338.condition(e)
	local c=e:GetHandler()
	local ph=Duel.GetCurrentPhase()
	local bc=c:GetBattleTarget()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
		and c:IsRelateToBattle() and bc and bc:GetSequence()>=5
end
