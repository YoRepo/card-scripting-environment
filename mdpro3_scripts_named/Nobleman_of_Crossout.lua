--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 抹杀之使徒  (ID: 71044499)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以场上1只里侧表示怪兽为对象才能发动。那只里侧表示怪兽破坏并除外。除外的怪兽是反转怪兽的场合，再让双方把双方卡组确认，从那之中由自己把除外的怪兽的同名怪兽全部除外。
--[[ __CARD_HEADER_END__ ]]

--抹殺の使徒
function c71044499.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c71044499.target)
	e1:SetOperation(c71044499.activate)
	c:RegisterEffect(e1)
end
function c71044499.filter(c)
	return c:IsFacedown() and c:IsAbleToRemove()
end
function c71044499.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c71044499.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c71044499.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c71044499.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c71044499.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() and tc:IsRelateToEffect(e)
		and Duel.Destroy(tc,REASON_EFFECT,LOCATION_REMOVED)>0
		and tc:IsLocation(LOCATION_REMOVED) and tc:IsType(TYPE_FLIP) then
		local code=tc:GetCode()
		local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,LOCATION_DECK,nil,code)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		g=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
		Duel.ConfirmCards(tp,g)
		g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleDeck(tp)
		Duel.ShuffleDeck(1-tp)
	end
end
