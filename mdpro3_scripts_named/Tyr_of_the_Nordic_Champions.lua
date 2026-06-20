--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 极星将 提尔  (ID: 2333365)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 2000 | DEF 2000
-- Setcode: 66
--
-- Effect Text:
-- 场上没有这张卡以外的名字带有「极星」的怪兽表侧表示存在的场合，这张卡破坏。只要这张卡在场上表侧表示存在，对方不能选择「极星将 提尔」以外的名字带有「极星」的怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--極星將テュール
function c2333365.initial_effect(c)
	--self destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c2333365.descon)
	c:RegisterEffect(e1)
	--battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetValue(c2333365.atlimit)
	c:RegisterEffect(e2)
end
function c2333365.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x42)
end
function c2333365.descon(e)
	return not Duel.IsExistingMatchingCard(c2333365.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c2333365.atlimit(e,c)
	return c:IsFaceup() and not c:IsCode(2333365) and c:IsSetCard(0x42)
end
