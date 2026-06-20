--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 天位骑士  (ID: 6150044)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 9
-- ATK 3800 | DEF 2500
--
-- Effect Text:
-- 「王后骑士」＋「卫兵骑士」＋「国王骑士」
-- 这张卡的融合召唤不用上记的卡不能进行。
-- ①：1回合1次，场上的这张卡为对象的怪兽的效果·魔法·陷阱卡发动时，把和那张卡相同种类（怪兽·魔法·陷阱）的1张手卡丢弃才能发动。那个效果无效。
--[[ __CARD_HEADER_END__ ]]

--アルカナ ナイトジョーカー
function c6150044.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,25652259,90876561,64788463,false,false)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6150044,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c6150044.discon)
	e1:SetCost(c6150044.discost)
	e1:SetTarget(c6150044.distg)
	e1:SetOperation(c6150044.disop)
	c:RegisterEffect(e1)
end
function c6150044.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsContains(c) and Duel.IsChainDisablable(ev)
end
function c6150044.filter(c,tpe)
	return c:IsType(tpe) and c:IsDiscardable()
end
function c6150044.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local rtype=bit.band(re:GetActiveType(),0x7)
	if chk==0 then return Duel.IsExistingMatchingCard(c6150044.filter,tp,LOCATION_HAND,0,1,nil,rtype) end
	Duel.DiscardHand(tp,c6150044.filter,1,1,REASON_COST+REASON_DISCARD,nil,rtype)
end
function c6150044.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c6150044.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
