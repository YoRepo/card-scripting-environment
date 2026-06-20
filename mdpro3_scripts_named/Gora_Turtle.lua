--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 筮龟  (ID: 80233946)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 1100 | DEF 1100
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，攻击力1900以上的怪兽不能进行攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--ゴラ・タートル
function c80233946.initial_effect(c)
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c80233946.atktarget)
	c:RegisterEffect(e1)
end
function c80233946.atktarget(e,c)
	return c:IsAttackAbove(1900)
end
