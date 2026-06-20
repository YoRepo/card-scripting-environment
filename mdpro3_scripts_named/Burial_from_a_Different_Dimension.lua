--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 来自异次元的埋葬  (ID: 48976825)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：从除外的自己以及对方的怪兽之中以合计最多3只为对象才能发动。那些怪兽回到墓地。
--[[ __CARD_HEADER_END__ ]]

--異次元からの埋葬
function c48976825.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c48976825.target)
	e1:SetOperation(c48976825.activate)
	c:RegisterEffect(e1)
end
function c48976825.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c48976825.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and c48976825.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c48976825.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(48976825,0))
	local g=Duel.SelectTarget(tp,c48976825.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c48976825.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_RETURN)
	end
end
