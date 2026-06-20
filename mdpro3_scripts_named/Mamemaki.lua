--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 撒豆  (ID: 83828288)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以对方场上1只表侧表示怪兽为对象才能发动。选那只怪兽的等级数量的自己手卡丢弃，自己从卡组抽出丢弃的数量。那之后，作为对象的怪兽回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--豆まき
function c83828288.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_DRAW+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c83828288.target)
	e1:SetOperation(c83828288.activate)
	c:RegisterEffect(e1)
end
function c83828288.filter(c,tp)
	local lv=c:GetLevel()
	return lv>0 and c:IsFaceup() and c:IsAbleToHand() and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>=lv and Duel.IsPlayerCanDraw(tp,lv)
end
function c83828288.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c83828288.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c83828288.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c83828288.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	local lv=g:GetFirst():GetLevel()
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,lv)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,lv)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c83828288.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local lv=tc:GetLevel()
	if tc:IsRelateToEffect(e) and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>=lv then
		local ct=Duel.DiscardHand(tp,aux.TRUE,lv,lv,REASON_EFFECT+REASON_DISCARD)
		if ct>0 and Duel.Draw(tp,lv,REASON_EFFECT)~=0 then
			Duel.BreakEffect()
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
		end
	end
end
