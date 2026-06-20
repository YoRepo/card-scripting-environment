--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 盟军·次世代集电人  (ID: 94622638)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1700 | DEF 0
-- Setcode: 2
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，持有和这张卡相同属性的自己场上的其他怪兽的攻击力上升500。
--[[ __CARD_HEADER_END__ ]]

--A・ジェネクス・パワーコール
function c94622638.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c94622638.atktg)
	e1:SetValue(500)
	c:RegisterEffect(e1)
end
function c94622638.atktg(e,c)
	return c~=e:GetHandler() and e:GetHandler():IsAttribute(c:GetAttribute())
end
