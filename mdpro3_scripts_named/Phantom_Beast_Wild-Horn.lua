--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 幻兽 野角驼鹿  (ID: 7576264)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 4
-- ATK 1700 | DEF 0
-- Setcode: 27
--
-- Effect Text:
-- 这张卡攻击守备表示怪兽时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--幻獣ワイルドホーン
function c7576264.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
