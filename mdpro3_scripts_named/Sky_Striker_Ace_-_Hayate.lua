--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 闪刀姬-飒天  (ID: 8491308)
-- Type: Monster / Effect / Link
-- Attribute: WIND
-- Race: Machine
-- ATK 1500 | LINK
-- Setcode: 4373
--
-- Effect Text:
-- 风属性以外的「闪刀姬」怪兽1只
-- 自己对「闪刀姬-飒天」1回合只能有1次特殊召唤。
-- ①：这张卡可以直接攻击。
-- ②：这张卡进行战斗的伤害计算后才能发动。从卡组把1张「闪刀」卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--閃刀姫－ハヤテ
function c8491308.initial_effect(c)
	c:SetSPSummonOnce(8491308)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c8491308.matfilter,1,1)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(8491308,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetTarget(c8491308.tgtg)
	e2:SetOperation(c8491308.tgop)
	c:RegisterEffect(e2)
end
function c8491308.matfilter(c)
	return c:IsLinkSetCard(0x1115) and c:IsLinkAttribute(ATTRIBUTE_ALL&~ATTRIBUTE_WIND)
end
function c8491308.tgfilter(c)
	return c:IsSetCard(0x115) and c:IsAbleToGrave()
end
function c8491308.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c8491308.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c8491308.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c8491308.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
