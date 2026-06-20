--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 借机巧藏  (ID: 80204957)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 17
--
-- Effect Text:
-- 选择自己场上表侧表示存在的1只名字带有「机巧」的怪兽发动。从自己卡组把1只4星以下的名字带有「机巧」的怪兽加入手卡，选择的怪兽的表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--借カラクリ蔵
function c80204957.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c80204957.target)
	e1:SetOperation(c80204957.activate)
	c:RegisterEffect(e1)
end
function c80204957.filter1(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x11) and c:IsAbleToHand()
end
function c80204957.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x11) and c:IsCanChangePosition()
end
function c80204957.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c80204957.filter2(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c80204957.filter1,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingTarget(c80204957.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c80204957.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c80204957.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c80204957.filter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
		end
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
