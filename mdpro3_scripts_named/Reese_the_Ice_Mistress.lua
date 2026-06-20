--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 冰弹使 蕾丝  (ID: 30276969)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 2
-- ATK 800 | DEF 800
--
-- Effect Text:
-- ①：这张卡不会被和4星以上的怪兽的战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--氷弾使いレイス
function c30276969.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c30276969.indes)
	c:RegisterEffect(e1)
end
function c30276969.indes(e,c)
	return c:IsLevelAbove(4)
end
