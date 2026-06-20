--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 变形斗士·磁铁U  (ID: 29947751)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Thunder
-- Level 3
-- ATK 800 | DEF 800
-- Setcode: 38
--
-- Effect Text:
-- 这张卡得到这张卡的表示形式的以下效果。
-- ●攻击表示：对方场上有表侧表示的怪兽存在的场合，这张卡只能选择攻击力最高的怪兽作为攻击对象。
-- ●守备表示：只要这张卡在场上表侧表示存在，对方不能选择其他怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--D・マグネンU
function c29947751.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetCondition(c29947751.cona)
	e1:SetValue(c29947751.vala)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e2:SetCondition(c29947751.cona)
	c:RegisterEffect(e2)
	--def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetCondition(c29947751.cond)
	e3:SetValue(c29947751.atlimit)
	c:RegisterEffect(e3)
end
function c29947751.cona(e)
	return e:GetHandler():IsAttackPos()
		and Duel.IsExistingMatchingCard(Card.IsFaceup,e:GetHandler():GetControler(),0,LOCATION_MZONE,1,nil)
end
function c29947751.filter(c,atk)
	return c:IsFaceup() and c:GetAttack()>atk
end
function c29947751.vala(e,c)
	if c:IsFaceup() then
		return Duel.IsExistingMatchingCard(c29947751.filter,c:GetControler(),LOCATION_MZONE,0,1,c,c:GetAttack())
	else return true end
end
function c29947751.cond(e)
	return e:GetHandler():IsDefensePos()
end
function c29947751.atlimit(e,c)
	return c~=e:GetHandler()
end
