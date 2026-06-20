--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 精灵术师 树精  (ID: 99414168)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 3
-- ATK 1200 | DEF 1400
--
-- Effect Text:
-- 「树精的祈祷」降临。这张卡的属性也同时当作「风」「水」「炎」「地」使用。
--[[ __CARD_HEADER_END__ ]]

--精霊術師 ドリアード
function c99414168.initial_effect(c)
	aux.AddCodeList(c,23965037)
	c:EnableReviveLimit()
	--Attribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_ATTRIBUTE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(0xf)
	c:RegisterEffect(e1)
end
