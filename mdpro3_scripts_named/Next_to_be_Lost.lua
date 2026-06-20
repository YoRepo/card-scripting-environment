--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 消失的后者  (ID: 7076131)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择自己场上表侧表示存在的1只怪兽。从自己卡组选1张和选择的卡同名的卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ロスト・ネクスト
function c7076131.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c7076131.target)
	e1:SetOperation(c7076131.activate)
	c:RegisterEffect(e1)
end
function c7076131.filter(c,code)
	return c:IsCode(code) and c:IsAbleToGrave()
end
function c7076131.tgfilter(c,tp)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c7076131.filter,tp,LOCATION_DECK,0,1,nil,c:GetCode())
end
function c7076131.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c7076131.tgfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c7076131.tgfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c7076131.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c7076131.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c7076131.filter,tp,LOCATION_DECK,0,1,1,nil,tc:GetCode())
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
