--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: W-弹射飞翼  (ID: 96300057)
-- Type: Monster / Effect / Union
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1300 | DEF 1500
--
-- Effect Text:
-- ①：1回合1次，可以从以下效果选择1个发动。
-- ●以自己场上1只「V-喷气虎」为对象，把这张卡当作装备卡使用给那只怪兽装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备的这张卡特殊召唤。
-- ②：装备怪兽的攻击力·守备力上升400。
--[[ __CARD_HEADER_END__ ]]

--W－ウィング・カタパルト
function c96300057.initial_effect(c)
	aux.EnableUnionAttribute(c,c96300057.filter)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(400)
	c:RegisterEffect(e3)
	--Def up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetValue(400)
	c:RegisterEffect(e4)
end
function c96300057.filter(c)
	return c:IsCode(51638941)
end
