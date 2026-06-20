--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 占术姬 水晶球水精  (ID: 67503139)
-- Type: Monster / Effect / Toon
-- Attribute: WATER
-- Race: Fairy
-- Level 5
-- ATK 1400 | DEF 2200
-- Setcode: 204
--
-- Effect Text:
-- ①：这张卡反转的场合才能发动。从自己的卡组·墓地选1只仪式怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--占術姫クリスタルウンディーネ
function c67503139.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c67503139.thtg)
	e1:SetOperation(c67503139.thop)
	c:RegisterEffect(e1)
end
function c67503139.thfilter(c)
	return bit.band(c:GetType(),0x81)==0x81 and c:IsAbleToHand()
end
function c67503139.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c67503139.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c67503139.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c67503139.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
