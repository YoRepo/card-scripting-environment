--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 入魔龙主 俄菲翁  (ID: 91279700)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Dragon
-- Rank 4
-- ATK 2550 | DEF 1650
-- Setcode: 10
--
-- Effect Text:
-- 4星「入魔」怪兽×2
-- ①：只要持有超量素材的这张卡在怪兽区域存在，双方不能把5星以上的怪兽特殊召唤。
-- ②：1回合1次，把这张卡1个超量素材取除才能发动。从卡组把1张「侵略的」魔法·陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ヴェルズ・オピオン
function c91279700.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xa),4,2)
	c:EnableReviveLimit()
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c91279700.sumlimit)
	e1:SetCondition(c91279700.dscon)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(91279700,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c91279700.cost)
	e2:SetTarget(c91279700.target)
	e2:SetOperation(c91279700.operation)
	c:RegisterEffect(e2)
end
function c91279700.dscon(e)
	return e:GetHandler():GetOverlayCount()~=0
end
function c91279700.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsLevelAbove(5)
end
function c91279700.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c91279700.filter(c)
	return c:IsSetCard(0x65) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c91279700.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c91279700.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c91279700.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c91279700.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
