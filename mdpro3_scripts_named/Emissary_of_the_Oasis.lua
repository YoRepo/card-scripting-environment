--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 绿洲的使者  (ID: 6103294)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 3
-- ATK 600 | DEF 400
--
-- Effect Text:
-- 当自己场上存在表侧表示的3星以下的通常怪兽时，对方不能选择这张卡作为攻击对象。当这张卡在自己场上以表侧表示存在时，这张卡的控制者所受到的，由3星以下的通常怪兽进行战斗所造成的战斗伤害为零。
--[[ __CARD_HEADER_END__ ]]

--オアシスの使者
function c6103294.initial_effect(c)
	--atk target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c6103294.atkcon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetTarget(c6103294.cfilter2)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	e3:SetTarget(c6103294.cfilter2)
	c:RegisterEffect(e3)
end
function c6103294.cfilter1(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsLevelBelow(3)
end
function c6103294.cfilter2(e,c)
	return c:IsType(TYPE_NORMAL) and c:IsLevelBelow(3)
end
function c6103294.atkcon(e)
	return Duel.IsExistingMatchingCard(c6103294.cfilter1,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
