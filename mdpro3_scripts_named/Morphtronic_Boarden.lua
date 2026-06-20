--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 变形斗士·滑板  (ID: 48381268)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 3
-- ATK 500 | DEF 1800
-- Setcode: 38
--
-- Effect Text:
-- ①：这张卡得到表示形式的以下效果。
-- ●攻击表示：只要这张卡在怪兽区域存在，自己的「变形斗士」怪兽可以直接攻击。
-- ●守备表示：只要这张卡在怪兽区域存在，这张卡以外的自己的「变形斗士」怪兽不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--D・ボードン
function c48381268.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c48381268.cona)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x26))
	c:RegisterEffect(e1)
	--def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c48381268.cond)
	e2:SetTarget(c48381268.tgd)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c48381268.cona(e)
	return e:GetHandler():IsAttackPos()
end
function c48381268.cond(e)
	return e:GetHandler():IsDefensePos()
end
function c48381268.tgd(e,c)
	return c:IsSetCard(0x26) and c~=e:GetHandler()
end
