--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 小子防御  (ID: 10759529)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上存在的1只「英雄小子」作为祭品。对方怪兽的攻击无效，从自己卡组把1只名字带有「元素英雄」的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--キッズ・ガード
function c10759529.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c10759529.condition)
	e1:SetCost(c10759529.cost)
	e1:SetTarget(c10759529.target)
	e1:SetOperation(c10759529.activate)
	c:RegisterEffect(e1)
end
function c10759529.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c10759529.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,32679370) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,32679370)
	Duel.Release(g,REASON_COST)
end
function c10759529.filter(c)
	return c:IsSetCard(0x3008) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c10759529.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10759529.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c10759529.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c10759529.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
