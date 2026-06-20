--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 胜利之风  (ID: 37301660)
-- Type: Spell / Field
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 装备怪兽的攻击力上升300，变成风属性。
--[[ __CARD_HEADER_END__ ]]

--WINDS OF VICTORY
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddEquipSpellEffect(c,true,true,Card.IsFaceup,nil)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(300)
	c:RegisterEffect(e1)
	--ATTRIBUTE
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e2:SetValue(ATTRIBUTE_WIND)
	c:RegisterEffect(e2)
end
