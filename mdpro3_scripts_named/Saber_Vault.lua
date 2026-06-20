--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 剑窖  (ID: 73787254)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 13
--
-- Effect Text:
-- 场上表侧表示存在的名字带有「X-剑士」的怪兽的攻击力上升自身等级×100，守备力下降自身等级×100。
--[[ __CARD_HEADER_END__ ]]

--セイバー・ヴォールト
function c73787254.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk,def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x100d))
	e2:SetValue(c73787254.val1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(c73787254.val2)
	c:RegisterEffect(e3)
end
function c73787254.val1(e,c)
	return c:GetLevel()*100
end
function c73787254.val2(e,c)
	return -c:GetLevel()*100
end
