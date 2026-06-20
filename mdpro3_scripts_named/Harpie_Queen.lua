--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 鹰身女王  (ID: 75064463)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1900 | DEF 1200
-- Setcode: 100
--
-- Effect Text:
-- ①：这张卡的卡名只要在场上·墓地存在当作「鹰身女郎」使用。
-- ②：把这张卡从手卡丢弃去墓地才能发动。从卡组把1张「鹰身女妖的狩猎场」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・クィーン
function c75064463.initial_effect(c)
	aux.AddCodeList(c,75782277)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75064463,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c75064463.cost)
	e1:SetTarget(c75064463.target)
	e1:SetOperation(c75064463.operation)
	c:RegisterEffect(e1)
	--change name
	aux.EnableChangeCode(c,76812113,LOCATION_MZONE+LOCATION_GRAVE)
end
function c75064463.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c75064463.filter(c)
	return c:IsCode(75782277) and c:IsAbleToHand()
end
function c75064463.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75064463.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75064463.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstMatchingCard(c75064463.filter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
