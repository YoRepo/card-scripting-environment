--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 幻奏的音女 埃勒姬  (ID: 79514956)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 5
-- ATK 2000 | DEF 1200
-- Setcode: 155
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，自己场上的特殊召唤的「幻奏」怪兽不会被效果破坏。
-- ②：只要特殊召唤的这张卡在怪兽区域存在，自己场上的天使族怪兽的攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--幻奏の音女エレジー
function c79514956.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c79514956.indtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_FAIRY))
	e2:SetValue(300)
	e2:SetCondition(c79514956.tgcon)
	c:RegisterEffect(e2)
end
function c79514956.indtg(e,c)
	return c:IsSetCard(0x9b) and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c79514956.tgcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
