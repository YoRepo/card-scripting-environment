--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 拟声连携  (ID: 6595475)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 314
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把1张手卡送去墓地才能发动。从卡组把以下怪兽之内各1只合计最多2只加入手卡。
-- ●「刷拉拉」怪兽
-- ●「我我我」怪兽
-- ●「隆隆隆」怪兽
-- ●「怒怒怒」怪兽
--[[ __CARD_HEADER_END__ ]]

--オノマト連携
function c6595475.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,6595475+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c6595475.cost)
	e1:SetTarget(c6595475.target)
	e1:SetOperation(c6595475.activate)
	c:RegisterEffect(e1)
end
function c6595475.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c6595475.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x54,0x59,0x82,0x8f) and c:IsAbleToHand()
end
function c6595475.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6595475.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6595475.check(g)
	if #g==1 then return true end
	local res=0x0
	if g:IsExists(Card.IsSetCard,1,nil,0x54) then res=res+0x1 end
	if g:IsExists(Card.IsSetCard,1,nil,0x59) then res=res+0x2 end
	if g:IsExists(Card.IsSetCard,1,nil,0x82) then res=res+0x4 end
	if g:IsExists(Card.IsSetCard,1,nil,0x8f) then res=res+0x8 end
	return res~=0x1 and res~=0x2 and res~=0x4 and res~=0x8
end
function c6595475.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c6595475.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=g:SelectSubGroup(tp,c6595475.check,false,1,2)
	Duel.SendtoHand(g1,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g1)
end
