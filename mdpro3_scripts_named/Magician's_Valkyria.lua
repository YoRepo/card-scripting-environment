--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 魔术女武神  (ID: 80304126)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1600 | DEF 1800
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，对方怪兽不能选择其他的魔法师族怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--マジシャンズ・ヴァルキリア
function c80304126.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c80304126.tg)
	c:RegisterEffect(e1)
end
function c80304126.tg(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
