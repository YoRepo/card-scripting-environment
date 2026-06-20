--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 亚特兰蒂斯的战士  (ID: 43797906)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 4
-- ATK 1900 | DEF 1200
--
-- Effect Text:
-- ①：把这张卡从手卡丢弃去墓地才能发动。从卡组把1张「传说之都 亚特兰蒂斯」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--アトランティスの戦士
function c43797906.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43797906,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c43797906.cost)
	e1:SetTarget(c43797906.target)
	e1:SetOperation(c43797906.operation)
	c:RegisterEffect(e1)
end
function c43797906.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c43797906.filter(c)
	return c:GetOriginalCode()==295517 and c:IsAbleToHand()
end
function c43797906.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c43797906.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c43797906.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstMatchingCard(c43797906.filter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
