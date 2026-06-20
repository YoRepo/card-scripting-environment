--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 特异英雄 恐惧破坏者  (ID: 63813056)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Warrior
-- ATK 2500 | LINK
-- Setcode: 8
--
-- Effect Text:
-- 「英雄」怪兽2只以上
-- ①：这张卡以及这张卡所连接区的「英雄」怪兽的攻击力上升自己墓地的「英雄」怪兽种类×100。
-- ②：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--X・HERO ドレッドバスター
function c63813056.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x8),2)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c63813056.atktg)
	e1:SetValue(c63813056.atkval)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c63813056.atktg(e,c)
	return c==e:GetHandler()
		or c:IsFaceup() and c:IsSetCard(0x8) and e:GetHandler():GetLinkedGroup():IsContains(c)
end
function c63813056.atkfilter(c)
	return c:IsSetCard(0x8) and c:IsType(TYPE_MONSTER)
end
function c63813056.atkval(e,c)
	return Duel.GetMatchingGroup(c63813056.atkfilter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil):GetClassCount(Card.GetCode)*100
end
