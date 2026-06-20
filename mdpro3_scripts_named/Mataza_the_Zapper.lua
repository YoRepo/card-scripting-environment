--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 奇袭的又佐  (ID: 22609617)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 3
-- ATK 1300 | DEF 800
--
-- Effect Text:
-- 这张卡在同1个战斗阶段中可以进行2次攻击。这张卡在场上以表侧表示存在时，控制权不能被变更。
--[[ __CARD_HEADER_END__ ]]

--不意打ち又佐
function c22609617.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e1)
	--double attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
