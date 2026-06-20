--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 蔷薇蝴蝶  (ID: 8910240)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 3
-- ATK 1400 | DEF 800
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，自己在通常召唤外加上只有1次，自己主要阶段可以把1只7星以上的怪兽表侧攻击表示上级召唤。
-- ②：只要自己场上有这张卡以外的昆虫族怪兽存在，这张卡可以直接攻击。
--[[ __CARD_HEADER_END__ ]]

--ローズ・パピヨン
function c8910240.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8910240,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsLevelAbove,7))
	e1:SetValue(0x1)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c8910240.dircon)
	c:RegisterEffect(e2)
end
function c8910240.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT)
end
function c8910240.dircon(e)
	return Duel.IsExistingMatchingCard(c8910240.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
