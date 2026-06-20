--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 善恶的彼岸  (ID: 62835876)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 177
--
-- Effect Text:
-- 「彼岸的鬼神 马拉布兰卡」的降临必需。「善恶的彼岸」的②的效果1回合只能使用1次。
-- ①：从自己的手卡·场上把等级合计直到6以上的怪兽解放，从手卡把「彼岸的鬼神 马拉布兰卡」仪式召唤。
-- ②：自己主要阶段把墓地的这张卡除外，从手卡把1只「彼岸」怪兽送去墓地才能发动。从卡组把1张「彼岸」卡加入手卡。这个效果在这张卡送去墓地的回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--善悪の彼岸
function c62835876.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,35330871)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,62835876)
	e1:SetCondition(aux.exccon)
	e1:SetCost(c62835876.thcost)
	e1:SetTarget(c62835876.thtg)
	e1:SetOperation(c62835876.thop)
	c:RegisterEffect(e1)
end
function c62835876.cfilter(c)
	return c:IsSetCard(0xb1) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c62835876.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c62835876.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
	Duel.DiscardHand(tp,c62835876.cfilter,1,1,REASON_COST,nil)
end
function c62835876.filter(c)
	return c:IsSetCard(0xb1) and c:IsAbleToHand()
end
function c62835876.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c62835876.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c62835876.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c62835876.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
