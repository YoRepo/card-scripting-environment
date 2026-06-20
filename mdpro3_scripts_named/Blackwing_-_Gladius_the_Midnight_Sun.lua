--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 黑羽-白夜之短剑鸟  (ID: 28190303)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 3
-- ATK 800 | DEF 1500
-- Setcode: 51
--
-- Effect Text:
-- ①：自己场上的表侧表示怪兽只有「黑羽-白夜之短剑鸟」以外的「黑羽」怪兽1只的场合，这张卡可以从手卡特殊召唤。
-- ②：这张卡1回合只有1次不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--BF－白夜のグラディウス
function c28190303.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c28190303.spcon)
	c:RegisterEffect(e1)
	--battle indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetCountLimit(1)
	e2:SetValue(c28190303.valcon)
	c:RegisterEffect(e2)
end
function c28190303.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	return g:GetCount()==1 and tc:IsSetCard(0x33) and not tc:IsCode(28190303)
end
function c28190303.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
