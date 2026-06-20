--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 海神的巫女  (ID: 17214465)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 4
-- ATK 700 | DEF 2000
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，场地变成「海」。场地魔法卡表侧表示存在的场合，这个效果不适用。
--[[ __CARD_HEADER_END__ ]]

--海神の巫女
function c17214465.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CHANGE_ENVIRONMENT)
	e1:SetValue(22702055)
	c:RegisterEffect(e1)
end
