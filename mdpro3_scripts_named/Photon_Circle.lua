--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 光子法阵师  (ID: 64145892)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1000 | DEF 1000
-- Setcode: 85
--
-- Effect Text:
-- 这张卡的战斗发生的对自己的战斗伤害变成一半。
--[[ __CARD_HEADER_END__ ]]

--フォトン・サークラー
function c64145892.initial_effect(c)
	--damage reduce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_INVOLVING_BATTLE_DAMAGE)
	e1:SetValue(aux.ChangeBattleDamage(0,HALF_DAMAGE))
	c:RegisterEffect(e1)
end
