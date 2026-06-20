--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 小走鹃  (ID: 36472900)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Winged Beast
-- Level 1
-- ATK 300 | DEF 300
--
-- Effect Text:
-- ①：这张卡不会被和攻击力1900以上的怪兽的战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--ロードランナー
function c36472900.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c36472900.indes)
	c:RegisterEffect(e1)
end
function c36472900.indes(e,c)
	if c:IsDefensePos() and Duel.GetAttacker()==c then
		return c:IsDefenseAbove(1900)
	else
		return c:IsAttackAbove(1900)
	end
end
