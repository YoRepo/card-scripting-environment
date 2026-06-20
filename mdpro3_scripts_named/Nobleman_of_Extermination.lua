--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 扑灭之使徒  (ID: 17449108)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 盖放的1张魔法或者陷阱卡破坏并且从游戏中除外。陷阱卡的场合把双方卡组确认，和破坏陷阱卡同名卡全部从游戏除外。
--[[ __CARD_HEADER_END__ ]]

--撲滅の使徒
function c17449108.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c17449108.target)
	e1:SetOperation(c17449108.activate)
	c:RegisterEffect(e1)
end
function c17449108.filter(c)
	return c:IsFacedown() and c:IsAbleToRemove()
end
function c17449108.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c17449108.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c17449108.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c17449108.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c17449108.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFacedown() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT,LOCATION_REMOVED)
		if tc:IsType(TYPE_TRAP) then
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
end
