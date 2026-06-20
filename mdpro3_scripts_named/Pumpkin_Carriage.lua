--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 南瓜马车  (ID: 14512825)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 3
-- ATK 0 | DEF 300
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，自己的「灰姑娘」可以直接攻击。
-- ②：只要这张卡在怪兽区域存在，自己场上的「急流山的金宫」不会被效果破坏，不会成为对方的效果的对象。
--[[ __CARD_HEADER_END__ ]]

--カボチャの馬車
function c14512825.initial_effect(c)
	aux.AddCodeList(c,72283691)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,78527720))
	c:RegisterEffect(e1)
	--indes/untarget
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetTarget(c14512825.indtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c14512825.indtg(e,c)
	return c:IsFaceup() and c:IsCode(72283691)
end
