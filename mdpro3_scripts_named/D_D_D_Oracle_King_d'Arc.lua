--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: DDD 神托王 达克  (ID: 82956492)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 7
-- ATK 2800 | DEF 2000
-- Setcode: 4271
--
-- Effect Text:
-- 「DD」怪兽×2
-- ①：只要这张卡在怪兽区域存在，给与自己伤害的效果变成让自己基本分回复的效果。
--[[ __CARD_HEADER_END__ ]]

--DDD神託王ダルク
function c82956492.initial_effect(c)
	--fusion material
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xaf),2,true)
	c:EnableReviveLimit()
	--damage conversion
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_REVERSE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetValue(c82956492.rev)
	c:RegisterEffect(e2)
end
function c82956492.rev(e,re,r,rp,rc)
	return bit.band(r,REASON_EFFECT)~=0
end
