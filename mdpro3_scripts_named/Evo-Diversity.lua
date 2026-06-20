--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 多样进化  (ID: 88760522)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 从卡组把1只名字带有「进化虫」或者「进化龙」的怪兽加入手卡。「多样进化」在1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--多様進化
function c88760522.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,88760522+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c88760522.target)
	e1:SetOperation(c88760522.activate)
	c:RegisterEffect(e1)
end
function c88760522.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x304e,0x604e) and c:IsAbleToHand()
end
function c88760522.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88760522.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c88760522.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c88760522.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
