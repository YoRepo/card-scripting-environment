--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 双头猛兽  (ID: 82035781)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast
-- Level 6
-- ATK 1700 | DEF 1900
--
-- Effect Text:
-- ①：这张卡在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--ツインヘデッド・ビースト
function c82035781.initial_effect(c)
	--multi attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
