--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 真文色龙  (ID: 67211766)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level 5
-- ATK 2000 | DEF 800
--
-- Effect Text:
-- 只要对方场上有魔法·陷阱卡存在，对方不能选择这张卡作为攻击对象。此外，这张卡向守备表示怪兽攻击时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--マジオシャレオン
function c67211766.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c67211766.ccon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c67211766.ccon(e)
	return Duel.IsExistingMatchingCard(Card.IsType,e:GetHandlerPlayer(),0,LOCATION_ONFIELD,1,nil,TYPE_SPELL+TYPE_TRAP)
end
