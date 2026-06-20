--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 强化支援机械·重装武器  (ID: 23265594)
-- Type: Monster / Effect / Union
-- Attribute: DARK
-- Race: Machine
-- Level 3
-- ATK 500 | DEF 500
--
-- Effect Text:
-- ①：1回合1次，可以从以下效果选择1个发动。
-- ●以自己场上1只机械族怪兽为对象，把这张卡当作装备卡使用给那只怪兽装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备的这张卡特殊召唤。
-- ②：装备怪兽的攻击力·守备力上升500。
--[[ __CARD_HEADER_END__ ]]

--強化支援メカ・ヘビーウェポン
function c23265594.initial_effect(c)
	aux.EnableUnionAttribute(c,c23265594.filter)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(500)
	c:RegisterEffect(e3)
	--Def up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetValue(500)
	c:RegisterEffect(e4)
end
function c23265594.filter(c)
	return c:IsRace(RACE_MACHINE)
end
