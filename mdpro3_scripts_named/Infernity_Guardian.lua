--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 永火守护者  (ID: 51566770)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1200 | DEF 1700
-- Setcode: 5373963
--
-- Effect Text:
-- 自己手卡是0张的场合，场上表侧表示存在的这张卡不会被战斗以及卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・ガーディアン
function c51566770.initial_effect(c)
	--cannot destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c51566770.condition)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c51566770.condition)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c51566770.condition(e)
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)==0
end
