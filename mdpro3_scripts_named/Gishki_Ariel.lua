--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 遗式术师·艾莉娅儿  (ID: 92784374)
-- Type: Monster / Effect / Toon
-- Attribute: WATER
-- Race: Spellcaster
-- Level 4
-- ATK 1000 | DEF 1800
-- Setcode: 58
--
-- Effect Text:
-- 反转：可以从卡组把1只名字带有「遗式」的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--リチュア・エリアル
function c92784374.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92784374,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c92784374.tg)
	e1:SetOperation(c92784374.op)
	c:RegisterEffect(e1)
end
function c92784374.filter(c)
	return c:IsSetCard(0x3a) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c92784374.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92784374.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c92784374.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c92784374.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
