--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 三眼死灵  (ID: 31464658)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 900 | DEF 800
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：把场上的这张卡送去墓地才能发动。从卡组把1只暗属性·10星怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--三眼の死霊
function c31464658.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31464658,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,31464658)
	e1:SetCost(c31464658.cost)
	e1:SetTarget(c31464658.target)
	e1:SetOperation(c31464658.operation)
	c:RegisterEffect(e1)
end
function c31464658.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() end
	Duel.SendtoGrave(c,REASON_COST)
end
function c31464658.thfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsLevel(10) and c:IsAbleToHand()
end
function c31464658.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c31464658.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c31464658.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c31464658.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
