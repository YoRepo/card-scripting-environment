--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 幻奏的音女 索娜塔  (ID: 76990617)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 3
-- ATK 1200 | DEF 1000
-- Setcode: 155
--
-- Effect Text:
-- ①：自己场上有「幻奏」怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：只要特殊召唤的这张卡在怪兽区域存在，自己场上的天使族怪兽的攻击力·守备力上升500。
--[[ __CARD_HEADER_END__ ]]

--幻奏の音女ソナタ
function c76990617.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c76990617.spcon)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_FAIRY))
	e2:SetValue(500)
	e2:SetCondition(c76990617.tgcon)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c76990617.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9b)
end
function c76990617.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c76990617.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c76990617.tgcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
