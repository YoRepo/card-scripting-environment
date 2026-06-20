--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: Z-金属履带  (ID: 64500000)
-- Type: Monster / Effect / Union
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1500 | DEF 1300
--
-- Effect Text:
-- ①：1回合1次，可以把1个以下效果发动。
-- ●以自己场上1只「X-首领加农」或「Y-龙头」为对象，把这张卡当作装备魔法卡使用来装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备状态的这张卡特殊召唤。
-- ②：装备怪兽的攻击力·守备力上升600。
--[[ __CARD_HEADER_END__ ]]

--Z－メタル・キャタピラー
function c64500000.initial_effect(c)
	aux.EnableUnionAttribute(c,c64500000.filter)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(600)
	c:RegisterEffect(e3)
	--Def up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetValue(600)
	c:RegisterEffect(e4)
end
function c64500000.filter(c)
	return c:IsCode(62651957,65622692)
end
