--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 盲信的哥布林  (ID: 35215622)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 1500
-- Setcode: 172
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，控制权不会被转移。
--[[ __CARD_HEADER_END__ ]]

--盲信するゴブリン
function c35215622.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e1)
end
