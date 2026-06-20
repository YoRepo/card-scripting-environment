--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 侵入魔鬼万能态  (ID: 62729173)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 2
-- ATK 1000 | DEF 0
-- Setcode: 4106
--
-- Effect Text:
-- 名字带有「侵入魔鬼」的怪兽上级召唤的场合，这张卡可以作为2只的数量解放。
--[[ __CARD_HEADER_END__ ]]

--インヴェルズ万能態
function c62729173.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c62729173.condition)
	c:RegisterEffect(e1)
end
function c62729173.condition(e,c)
	return c:IsSetCard(0x100a)
end
