--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 占术姬 弓箭风精  (ID: 31118030)
-- Type: Monster / Effect / Toon
-- Attribute: WIND
-- Race: Fairy
-- Level 4
-- ATK 1000 | DEF 1400
-- Setcode: 204
--
-- Effect Text:
-- ①：这张卡反转的场合才能发动。从自己的卡组·墓地选1张仪式魔法卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--占術姫アローシルフ
function c31118030.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c31118030.thtg)
	e1:SetOperation(c31118030.thop)
	c:RegisterEffect(e1)
end
function c31118030.thfilter(c)
	return bit.band(c:GetType(),0x82)==0x82 and c:IsAbleToHand()
end
function c31118030.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c31118030.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c31118030.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c31118030.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
