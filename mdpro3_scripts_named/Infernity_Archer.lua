--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 永火弓手  (ID: 18724123)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 2000 | DEF 1000
-- Setcode: 11
--
-- Effect Text:
-- 自己手卡是0张的场合，这张卡可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・アーチャー
function c18724123.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c18724123.con)
	c:RegisterEffect(e1)
end
function c18724123.con(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)==0
end
