--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 同调驱逐  (ID: 75105429)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 23
--
-- Effect Text:
-- 选择对方场上表侧表示存在的1只同调怪兽从游戏中除外，对方从卡组抽1张卡。
--[[ __CARD_HEADER_END__ ]]

--シンクロ・イジェクション
function c75105429.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c75105429.target)
	e1:SetOperation(c75105429.operation)
	c:RegisterEffect(e1)
end
function c75105429.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsAbleToRemove()
end
function c75105429.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c75105429.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75105429.filter,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c75105429.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c75105429.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and Duel.Remove(tc,0,REASON_EFFECT)~=0 then
		Duel.Draw(1-tp,1,REASON_EFFECT)
	end
end
