--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 机甲狙击兵  (ID: 23782705)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1800 | DEF 800
-- Setcode: 54
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，双方不能向「机甲狙击兵」以外的「机甲」怪兽攻击。
--[[ __CARD_HEADER_END__ ]]

--マシンナーズ・スナイパー
function c23782705.initial_effect(c)
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c23782705.tg)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
end
function c23782705.tg(e,c)
	return c:IsSetCard(0x36) and not c:IsCode(23782705)
end
