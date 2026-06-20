--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 龙骑兵团-叉龙  (ID: 54455664)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Dragon
-- Level 1
-- ATK 600 | DEF 400
-- Setcode: 41
--
-- Effect Text:
-- ①：把这张卡当作装备卡使用来装备的怪兽在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－ブランディストック
function c54455664.initial_effect(c)
	--Double Attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
