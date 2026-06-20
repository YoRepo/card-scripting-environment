--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 黑龙降临  (ID: 18803791)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「黑龙之圣骑士」的降临必需。
-- ①：从自己的手卡·场上把等级合计直到4以上的怪兽解放，从手卡把「黑龙之圣骑士」仪式召唤。
-- ②：自己主要阶段把墓地的这张卡除外才能发动。从卡组把1张「真红眼」魔法·陷阱卡加入手卡。这个效果在这张卡送去墓地的回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--黒竜降臨
function c18803791.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,71408082)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(aux.exccon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c18803791.thtg)
	e1:SetOperation(c18803791.thop)
	c:RegisterEffect(e1)
end
function c18803791.thfilter(c)
	return c:IsSetCard(0x3b) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c18803791.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c18803791.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c18803791.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c18803791.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
