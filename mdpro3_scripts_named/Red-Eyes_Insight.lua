--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 真红眼看破  (ID: 92353449)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 59
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从手卡·卡组把1只「真红眼」怪兽送去墓地才能发动。从卡组把「真红眼看破」以外的1张「真红眼」魔法·陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--レッドアイズ・インサイト
function c92353449.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,92353449+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c92353449.cost)
	e1:SetTarget(c92353449.target)
	e1:SetOperation(c92353449.activate)
	c:RegisterEffect(e1)
end
function c92353449.cfilter(c)
	return c:IsSetCard(0x3b) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c92353449.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92353449.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c92353449.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c92353449.thfilter(c)
	return c:IsSetCard(0x3b) and c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsCode(92353449) and c:IsAbleToHand()
end
function c92353449.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92353449.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c92353449.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c92353449.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
