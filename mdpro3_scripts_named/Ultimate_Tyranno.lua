--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 究极恐兽  (ID: 15894048)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 8
-- ATK 3000 | DEF 2200
--
-- Effect Text:
-- ①：自己战斗阶段有可以攻击的「究极恐兽」存在的场合，「究极恐兽」以外的怪兽不能攻击。
-- ②：这张卡可以向对方怪兽全部各作1次攻击。
--[[ __CARD_HEADER_END__ ]]

--究極恐獣
function c15894048.initial_effect(c)
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c15894048.cacon)
	e1:SetTarget(c15894048.catg)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_ATTACK_ALL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c15894048.cacon(e)
	return Duel.IsBattlePhase() and Duel.IsTurnPlayer(e:GetHandlerPlayer())
end
function c15894048.catg(e,c)
	return not c:IsCode(15894048)
		and Duel.IsExistingMatchingCard(c15894048.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,c)
end
function c15894048.cfilter(c)
	if not (c:IsCode(15894048) and c:IsAttackable()) then return false end
	local ag,direct=c:GetAttackableTarget()
	return ag:GetCount()>0 or direct
end
