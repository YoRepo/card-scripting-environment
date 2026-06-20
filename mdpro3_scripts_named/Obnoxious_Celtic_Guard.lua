--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 翻弄敌人的精灵剑士  (ID: 52077741)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1400 | DEF 1200
-- Setcode: 228
--
-- Effect Text:
-- ①：这张卡不会被和攻击力1900以上的怪兽的战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--翻弄するエルフの剣士
function c52077741.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c52077741.indes)
	c:RegisterEffect(e1)
end
function c52077741.indes(e,c)
	if c:IsDefensePos() and Duel.GetAttacker()==c then
		return c:IsDefenseAbove(1900)
	else
		return c:IsAttackAbove(1900)
	end
end
