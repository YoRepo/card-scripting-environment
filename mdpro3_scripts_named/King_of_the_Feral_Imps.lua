--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 精怪王  (ID: 11398059)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Reptile
-- Rank 4
-- ATK 2300 | DEF 2000
--
-- Effect Text:
-- 4星怪兽×2
-- ①：1回合1次，把这张卡1个超量素材取除才能发动。从卡组把1只爬虫类族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--キングレムリン
function c11398059.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11398059,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c11398059.cost)
	e1:SetTarget(c11398059.target)
	e1:SetOperation(c11398059.operation)
	c:RegisterEffect(e1)
end
function c11398059.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c11398059.filter(c)
	return c:IsRace(RACE_REPTILE) and c:IsAbleToHand()
end
function c11398059.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11398059.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c11398059.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c11398059.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
