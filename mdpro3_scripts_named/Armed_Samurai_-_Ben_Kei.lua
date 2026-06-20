--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 重装武者-弁庆  (ID: 84430950)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 4
-- ATK 500 | DEF 800
--
-- Effect Text:
-- 每次的战斗阶段中，这张卡在通常攻击之上追加、这张卡装备的装备卡数量的攻击次数。
--[[ __CARD_HEADER_END__ ]]

--重装武者－ベン・ケイ
function c84430950.initial_effect(c)
	--multi attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(c84430950.val)
	c:RegisterEffect(e1)
end
function c84430950.val(e,c)
	return c:GetEquipCount()
end
