--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 堕天使护士-蕾菲库儿  (ID: 67316075)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level 4
-- ATK 1400 | DEF 600
-- Setcode: 239
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，对方基本分回复的效果变成给与对方基本分伤害的效果。
--[[ __CARD_HEADER_END__ ]]

--堕天使ナース－レフィキュル
function c67316075.initial_effect(c)
	--recover conversion
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_REVERSE_RECOVER)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
