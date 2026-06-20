--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 钢核初期化  (ID: 91985515)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 29
--
-- Effect Text:
-- 把自己场上存在的1只名字带有「核成」的怪兽解放发动。从自己的卡组·墓地把1张「核成兽的钢核」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--鋼核初期化
function c91985515.initial_effect(c)
	aux.AddCodeList(c,36623431)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c91985515.cost)
	e1:SetTarget(c91985515.target)
	e1:SetOperation(c91985515.activate)
	c:RegisterEffect(e1)
end
function c91985515.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x1d) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x1d)
	Duel.Release(g,REASON_COST)
end
function c91985515.filter(c)
	return c:IsCode(36623431) and c:IsAbleToHand()
end
function c91985515.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c91985515.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c91985515.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c91985515.filter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
