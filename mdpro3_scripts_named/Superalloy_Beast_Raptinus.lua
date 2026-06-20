--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 超合魔兽 拉普提诺斯  (ID: 64463828)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Dragon
-- Level 8
-- ATK 2200 | DEF 2200
--
-- Effect Text:
-- 二重怪兽×2
-- ①：只要这张卡在怪兽区域存在，场上的二重怪兽当作再1次召唤的状态使用。
--[[ __CARD_HEADER_END__ ]]

--超合魔獣ラプテノス
function c64463828.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionType,TYPE_DUAL),2,true)
	--duel status
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_DUAL))
	e1:SetCode(EFFECT_DUAL_STATUS)
	c:RegisterEffect(e1)
end
