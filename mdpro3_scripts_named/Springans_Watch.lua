--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 护宝炮妖监视  (ID: 23499963)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 341
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把1张「大沙海 黄金戈尔工达」加入手卡。自己的场地区域有「大沙海 黄金戈尔工达」存在的场合，可以作为代替让以下效果适用。
-- ●从卡组把1只「护宝炮妖」怪兽加入手卡，从卡组把1只「护宝炮妖」怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--スプリガンズ・ウォッチ
function c23499963.initial_effect(c)
	aux.AddCodeList(c,60884672)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,23499963+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c23499963.target)
	e1:SetOperation(c23499963.activate)
	c:RegisterEffect(e1)
end
function c23499963.filter(c)
	return c:IsCode(60884672) and c:IsAbleToHand()
end
function c23499963.thfilter(c,tp)
	return c:IsSetCard(0x155) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and Duel.IsExistingMatchingCard(c23499963.tgfilter,tp,LOCATION_DECK,0,1,c)
end
function c23499963.tgfilter(c)
	return c:IsSetCard(0x155) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c23499963.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local b=Duel.IsEnvironment(60884672,tp,LOCATION_FZONE)
	if chk==0 then return Duel.IsExistingMatchingCard(c23499963.filter,tp,LOCATION_DECK,0,1,nil) or b and Duel.IsExistingMatchingCard(c23499963.thfilter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,0,tp,LOCATION_DECK)
end
function c23499963.activate(e,tp,eg,ep,ev,re,r,rp)
	local b=Duel.IsEnvironment(60884672,tp,LOCATION_FZONE)
	if b and Duel.IsExistingMatchingCard(c23499963.thfilter,tp,LOCATION_DECK,0,1,nil,tp) and (not Duel.IsExistingMatchingCard(c23499963.filter,tp,LOCATION_DECK,0,1,nil) or Duel.SelectYesNo(tp,aux.Stringid(23499963,0))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c23499963.thfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
		local tc=g:GetFirst()
		if Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
			Duel.ConfirmCards(1-tp,tc)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local tg=Duel.SelectMatchingCard(tp,c23499963.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
			Duel.SendtoGrave(tg,REASON_EFFECT)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c23499963.filter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
