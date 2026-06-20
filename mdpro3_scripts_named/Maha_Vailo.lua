--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 摩诃毗卢  (ID: 93013676)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1550 | DEF 1400
--
-- Effect Text:
-- ①：这张卡的攻击力上升这张卡装备的装备卡数量×500。
--[[ __CARD_HEADER_END__ ]]

--マハー・ヴァイロ
function c93013676.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c93013676.val)
	c:RegisterEffect(e1)
end
function c93013676.val(e,c)
	return c:GetEquipCount()*500
end
