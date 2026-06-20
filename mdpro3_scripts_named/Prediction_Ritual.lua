--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 圣占术的仪式  (ID: 30392583)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「圣占术姬 塔罗光巫女」的降临必需。
-- ①：从自己的手卡·场上把等级合计直到9以上的怪兽解放，从手卡把「圣占术姬 塔罗光巫女」仪式召唤。
-- ②：自己主要阶段把墓地的这张卡除外才能发动。从卡组把1只「占术姬」怪兽加入手卡。这个效果在这张卡送去墓地的回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--聖占術の儀式
function c30392583.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,94997874)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(aux.exccon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c30392583.thtg)
	e1:SetOperation(c30392583.thop)
	c:RegisterEffect(e1)
end
function c30392583.thfilter(c)
	return c:IsSetCard(0xcc) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c30392583.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30392583.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c30392583.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c30392583.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
