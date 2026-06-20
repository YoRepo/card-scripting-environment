--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 光子蜥蜴  (ID: 38973775)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 3
-- ATK 900 | DEF 1200
-- Setcode: 85
--
-- Effect Text:
-- 把这张卡解放才能发动。从卡组把1只4星以下的名字带有「光子」的怪兽加入手卡。「光子蜥蜴」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--フォトン・リザード
function c38973775.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(38973775,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,38973775)
	e1:SetCost(c38973775.cost)
	e1:SetTarget(c38973775.target)
	e1:SetOperation(c38973775.operation)
	c:RegisterEffect(e1)
end
function c38973775.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c38973775.filter(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x55) and c:IsAbleToHand()
end
function c38973775.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c38973775.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c38973775.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c38973775.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
