--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 比翼连鳞  (ID: 70298454)
-- Type: Monster / Effect / Union
-- Attribute: DARK
-- Race: Dragon
-- Level 3
-- ATK 1500 | DEF 0
--
-- Effect Text:
-- ①：1回合1次，可以从以下效果选择1个发动。
-- ●以自己场上1只表侧表示怪兽为对象，把这张卡当作装备卡使用给那只怪兽装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备的这张卡特殊召唤。
-- ②：装备怪兽的原本攻击力变成1000，同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--比翼レンリン
function c70298454.initial_effect(c)
	aux.EnableUnionAttribute(c,aux.TRUE)
	--change atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_SET_BASE_ATTACK)
	e4:SetValue(1000)
	c:RegisterEffect(e4)
	--double attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_EXTRA_ATTACK)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
