--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 扰乱骑士  (ID: 40391316)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Beast
-- Level 5
-- ATK 0 | DEF 2500
-- Setcode: 15
--
-- Effect Text:
-- 「扰乱」怪兽×2
-- ①：这张卡在怪兽区域表侧表示存在期间，指定没有使用的对方的怪兽区域最多2处，那些区域不能使用。
--[[ __CARD_HEADER_END__ ]]

--おジャマ・ナイト
function c40391316.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xf),2,true)
	--disable field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_DISABLE_FIELD)
	e2:SetOperation(c40391316.disop)
	c:RegisterEffect(e2)
end
function c40391316.disop(e,tp)
	local c=Duel.GetLocationCount(1-tp,LOCATION_MZONE,PLAYER_NONE,0)
	if c==0 then return end
	local dis1=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)
	if c>1 and Duel.SelectYesNo(tp,aux.Stringid(40391316,0)) then
		local dis2=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,dis1)
		dis1=bit.bor(dis1,dis2)
	end
	return dis1
end
